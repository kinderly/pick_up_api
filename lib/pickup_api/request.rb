module PickupApi
  class Request
    URL = 'http://185.22.234.24/pickup_test/ws/pickupexchange.1cws?wsdl'
    LOGIN = 'WS'
    PASSWORD = '123'
    AUTH_CODE = 'Idrp1VUUYm'
    OPERATIONS = %i(get_parcelshop_list_xml push_orders_xml
                    get_orders_history_xml get_orders_list_xml)

    def initialize(action, params)
      @action = action
      @orders = params[:orders]
      @start_date = params[:start_date] || Date.today.to_s
      @end_date = params[:end_date] || Date.today.to_s
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
