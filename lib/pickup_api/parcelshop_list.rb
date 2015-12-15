module PickupApi
  class ParcelshopList
    def list
      request = Request.new(:get_parcelshop_list_xml)
      response = request.result
      list = response.body[:get_parcelshop_list_xml_response][:return]
      parser = Nori.new
      doc = Nokogiri::XML(list)
      doc.at('ParcelshopList').children.to_a.reject do |item|
        item.is_a? Nokogiri::XML::Text
      end.map(&:to_s).map { |item| parser.parse(item) }
    end
  end
end
