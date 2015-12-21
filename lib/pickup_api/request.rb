module PickupApi
  class Request
    OPERATIONS = %i(get_parcelshop_list_xml push_orders_xml
                    get_orders_history_xml get_orders_list_xml)

    def initialize(action, params = {})
      @action = action
      @orders = params[:orders]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @order_number = params[:order_number].to_s
      @format = params[:format] || 'XML'
      @url = ENV['pickup_api_url']
      @login = ENV['pickup_login']
      @password = ENV['pickup_password']
      @auth_code = ENV['pickup_auth_code']
    end

    def result
      unless OPERATIONS.include?(@action)
        fail NoMethodError, 'Wrong action', caller
      end
      case @action
      when :get_parcelshop_list_xml
        message = {}
      when :push_orders_xml
        message = {
          'AuthorizationCode' => @auth_code,
          'Orders' => @orders
        }
      else
        message = {
          'AuthorizationCode' => @auth_code,
          'StartDate' => @start_date,
          'EndDate' => @end_date,
          'OrderNr' => @order_number,
          'Format' => @format
        }
      end
      @client = Savon.client(wsdl: @url, basic_auth: [@login, @password])
      @client.call(@action, message: message)
    end
  end
end
