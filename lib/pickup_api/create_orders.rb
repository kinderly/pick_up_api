module PickupApi
  class CreateOrders
    def initialize(*orders)
      @orders = orders
    end

    def send
      @orders.map { |order| send_order(order) }
    end

    private

    def send_order(order)
      xml_order = OrdersSerializer.to_xml(order)
      request = Request.new(:push_orders_xml, orders: xml_order)
      response = request.result
      doc = Nokogiri::XML(response.body[:push_orders_xml_response][:return])
      if doc.at('result')['status'] == 'Загружено'
        {
          status: 'ok',
          order_info: {
            status: doc.at('order')['status'],
            service_number: doc.at('order')['numberPickup'],
            number: doc.at('order')['numberSender']
          }
        }
      else
        {
          status: 'error',
          order_info: {
            status: 'error',
            number: order.order_number
          }
        }
      end
    end
  end
end
