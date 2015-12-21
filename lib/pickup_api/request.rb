module PickupApi
  class Request
    URL = ENV['pickup_api_url']
    LOGIN = ENV['pickup_login']
    PASSWORD = ENV['pickup_password']
    AUTH_CODE = ENV['pickup_auth_code']
    OPERATIONS = %i(get_parcelshop_list_xml push_orders_xml
                    get_orders_history_xml get_orders_list_xml)

    def initialize(action, params = {})
      @action = action
      @orders = params[:orders]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @order_number = params[:order_number].to_s
      @format = params[:format] || 'XML'
      @client = Savon.client(wsdl: URL, basic_auth: [LOGIN, PASSWORD])
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
          'AuthorizationCode' => AUTH_CODE,
          'Orders' => @orders
        }
      else
        message = {
          'AuthorizationCode' => AUTH_CODE,
          'StartDate' => @start_date,
          'EndDate' => @end_date,
          'OrderNr' => @order_number,
          'Format' => @format
        }
      end
      @client.call(@action, message: message)
    end
  end
end
