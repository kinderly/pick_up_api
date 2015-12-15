module PickupApi
  class OrdersList
    def initialize(start_date, end_date, order_number = nil, format = 'XML')
      @start_date = start_date
      @end_date = end_date
      @order_number = order_number
      @format = format
    end

    def get
      # [{"@OrderNum"=>"AP-122159-1",
      #   "@OrderDate"=>"2015-12-01T16:00:22",
      #   "@CustomerName"=>"БЕЙБИБУМ",
      #   "@CustomerPhone"=>"321654",
      #   "@Item"=>"122159-1 че-то везем!",
      #   "@ItemCode"=>"3311242",
      #   "@OrderQty"=>"1",
      #   "@OrderPrice"=>"1500",
      #   "@OrderSumm"=>"1500",
      #   "@ParselshopCode"=>"",
      #   "@ParselshopName"=>"",
      #   "@ArrivalDate"=>"",
      #   "@ArrivalNum"=>"",
      #   "@ArrivalQty"=>"0",
      #   "@DeliveryDate"=>"",
      #   "@DeliveryQty"=>"0",
      #   "@DeliverySumm"=>"0",
      #   "@RefuseQty"=>"0",
      #   "@ReturnDate"=>"",
      #   "@ReturnNum"=>"",
      #   "@ReturnQty"=>"0",
      #   "@Status"=>"Зарегистрирован"},
      #   ...
      # ]


      params_hash = {
        start_date: @start_date,
        end_date: @end_date,
        order_number: @order_number,
        format: @format
      }
      request = Request.new(:get_orders_list_xml, params_hash)
      response = request.result
      list = response.body[:get_orders_list_xml_response][:return]
      parser = Nori.new
      doc = Nokogiri::XML(list)
      binding.pry
      res = doc.at('OrderList').children.to_a.reject do |item|
        item.is_a? Nokogiri::XML::Text
      end.map(&:to_s).map { |item| parser.parse(item) }.map(&:values).flatten
    end
  end
end
