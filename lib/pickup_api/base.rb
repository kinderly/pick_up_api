module PickupApi
  class Base
    ATTRIBUTES = %i(xml_type xml_name optional type array max_occurs)

    class << self
      def xml_element=(element_name)
        @xml_element = element_name
      end

      def xml_field(*args)
        options = extract_options(*args)
        options.keys.each do |key|
          fail "Wrong attribute #{key}" unless ATTRIBUTES.include?(key)
        end
        args.each do |attr_name|
          @attr_info ||= {}
          @attr_info[attr_name] = options
          attr_accessor attr_name
        end
      end

      def xml_attribute(*args)
        options = extract_options
        args << options.merge(xml_type: attribute)
        xml_field(args)
      end

      def xml_field_array(name, options = {})
        xml_field(name, options.merge(array: true))
      end

      def attribute_meta
        res = if superclass.respond_to?(:attribute_meta)
          superclass.attribute_meta
        else
          {}
        end
        res.merge(@attr_info || {})
      end

      def tag_name
        return @xml_element unless @xml_element.nil?
        if superclass.respond_to?(:tag_name)
          superclass.tag_name
        else
          fail 'xml element not specified'
        end
      end

      def extract_options(args)
        if args.is_a?(Hash) && args.last.instance_of?(Hash)
          args.pop
        else
          {}
        end
      end
    end

    def tag_name
      self.class.tag_name
    end

    def initialize
      self.class.attribute_meta.each do |k, v|
        if v[:array]
          self.send("#{k}=".to_sym, [])
        elsif v[:type]
          self.send("#{k}=", v[:type].new)
        end
      end
    end
  end
end
