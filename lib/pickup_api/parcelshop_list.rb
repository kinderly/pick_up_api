module PickupApi
  class ParcelshopList
    def list

      # [{
      #   "Parcelshop"=>
      #   {
      #     "WorkingHours"=>
      #       [
      #         { "@Day"=>"Mon","@Open"=>"10", "@Closed"=>"21"},
      #         {"@Day"=>"Tue", "@Open"=>"10", "@Closed"=>"21"},
      #         {"@Day"=>"Wed", "@Open"=>"10", "@Closed"=>"21"},
      #         {"@Day"=>"Thu", "@Open"=>"10", "@Closed"=>"21"},
      #         {"@Day"=>"Fri", "@Open"=>"10", "@Closed"=>"21"},
      #         {"@Day"=>"Sat", "@Open"=>"10", "@Closed"=>"21"},
      #         {"@Day"=>"Sun", "@Open"=>"10", "@Closed"=>"19"}
      #       ],
      #     "@GPSCoordinates"=>"55.730395,37.645332",
      #     "@Name"=>"10001 Кожевники",
      #     "@Code"=>"10001",
      #     "@Address"=>"115114, Москва г, Кожевническая ул, дом № 7, строение 1",
      #     "@Region"=>"Москва",
      #     "@City"=>"",
      #     "@Street"=>"Кожевническая ул",
      #     "@House"=>"дом № 7, строение 1",
      #     "@Postcode"=>"115114",
      #     "@Phone"=>"+7 (926) 083-1941",
      #     "@AdditionalInfo"=>"Выход из м.Павелецкая радиальная, через здание" \
      #       " Павелецкого вокзала. Повернуть направо, в сторону трамвайных " \
      #       "путей и ул.Кожевническая. Пройти до ТЦ \"Кожевники\". "\
      #       " Пункт выдачи расположен на 4 этаже",
      #     "@Area"=>"0",
      #     "@DressingRoomQty"=>"0",
      #     "@SubwayStation"=>"00000000-0000-0000-0000-000000000000",
      #     "@SubwayStationDistance"=>"0",
      #     "@PaymentMethods"=>"Наличные / Карта",
      #     "@Cash"=>"1",
      #     "@Card"=>"1",
      #     "@DeliveryDelay"=>"1"
      #   }
      # },
      # .....
      # ]

      request = Request.new(:get_parcelshop_list_xml)
      response = request.result
      list = response.body[:get_parcelshop_list_xml_response][:return]
      parser = Nori.new
      doc = Nokogiri::XML(list)
      doc.at('ParcelshopList').children.to_a.reject do |item|
        item.is_a? Nokogiri::XML::Text
      end.map(&:to_s).map { |item| parser.parse(item) }
    end
  end
end
