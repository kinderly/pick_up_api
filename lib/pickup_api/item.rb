module PickupApi
  class Item
    attr_accessor :title, :code, :barcode, :quantity, :price, :to_pay, :order,
                  :type

    def initialize(order)
      @order = order
    end
  end
end
