module PickupApi
  class OrdersSerializer
    class << self
      def to_xml(*orders)
        Nokogiri::XML::Builder.new do |xml|
          xml.OrdersList do
            orders.each do |order|
              order.items.each do |item|
                xml.OrderData(
                  ParcelShopCode: order.parcel_shop_code,
                  DeliveryDate: order.delivery_date,
                  OrderNum: order.order_number,
                  ParcelNum: order.parcel_number,
                  CustomerName: order.customer_name,
                  CustomerPhone: order.customer_phone,
                  Item: item.title,
                  ItemCode: item.code,
                  ItemType: item.type,
                  ItemBarcode: item.barcode,
                  Qty: item.quantity,
                  ItemPrice: item.price,
                  PriceToPay: item.to_pay,
                  Comment: order.comment,
                  OrderBarcode: order.barcode,
                  Invoice: order.invoice,
                  Seller: order.seller
                )
              end
            end
          end
        end.to_xml
      end
    end
  end
end
