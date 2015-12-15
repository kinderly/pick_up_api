module PickupApi
  class Order
    attr_accessor :parcel_shop_code, :delivery_date, :order_number,
                  :parcel_number, :customer_name, :customer_phone, :comment,
                  :seller, :order_barcode, :invoice

    attr_reader :items

    def initialize
      @items = []
    end

    def add_item(item)
      fail ArgumentError, 'Wrong Item' unless item.is_a? Item
      @items << item
    end
  end
end
