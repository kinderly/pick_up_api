module PickupApi
  class Item
    attr_accessor :title, :code, :barcode, :quantity, :price, :to_pay, :order

    def initialize(order)
      @order = order
    end
  end
end
