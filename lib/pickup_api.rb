module PickupApi
  require_relative 'pickup_api/request.rb'
  require_relative 'pickup_api/item.rb'
  require_relative 'pickup_api/order.rb'
  require_relative 'pickup_api/orders_serializer.rb'
  require_relative 'pickup_api/create_orders.rb'
  require_relative 'pickup_api/parcelshop_list.rb'
  require_relative 'pickup_api/orders_history.rb'
  require_relative 'pickup_api/orders_list.rb'
  require 'nokogiri'
  require 'savon'
  require 'nori'
end

