module PickupApi
  class OrdersHistory
    def initialize(start_date, end_date, order_number = nil, format = 'XML')
      @start_date = start_date
      @end_date = end_date
      @order_number = order_number
      @format = format
    end

    def get
      # Returns array of order hashes, like a
      # [{"@OrderNum"=>"AP-122159-1",
      #   "@ParcelShopCode"=>"",
      #   "@ParcelShopName"=>"",
      #   "@TransactionDate"=>"2015-12-01T16:00:22",
      #   "@TransactionType"=>"register",
      #   "@Item"=>"122159-1 че-то везем!",
      #   "@ItemCode"=>"3311242",
      #   "@ItemBarcode"=>"122159-1",
      #   "@Qty"=>"1",
      #   "@Price"=>"1500"},
      #  {"@OrderNum"=>"AP-122159-2",
      #   "@ParcelShopCode"=>"",
      #   "@ParcelShopName"=>"",
      #   "@TransactionDate"=>"2015-12-01T16:00:26",
      #   "@TransactionType"=>"register",
      #   "@Item"=>"122159-2 Без названия",
      #   "@ItemCode"=>"3311243",
      #   "@ItemBarcode"=>"122159-2",
      #   "@Qty"=>"2",
      #   "@Price"=>"6000"},
      #    ....
      #  ]
      params_hash = {
        start_date: @start_date,
        end_date: @end_date,
        order_number: @order_number,
        format: @format
      }
      request = Request.new(:get_orders_history_xml, params_hash)
      response = request.result
      list = response.body[:get_orders_history_xml_response][:return]
      parser = Nori.new
      doc = Nokogiri::XML(list)
      doc.at('Orderhistory').children.to_a.reject do |item|
        item.is_a? Nokogiri::XML::Text
      end.map(&:to_s).map { |item| parser.parse(item) }.map(&:values).flatten
    end
  end
end
