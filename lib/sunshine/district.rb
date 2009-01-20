module Sunshine
  class District < Base
    def zipcodes
      @zipcodes ||= self.class.zipcodes_for_state_and_number(state, number)
    end
    
    class << self
      def find_by_zipcode(zip)
        response = fetch('districts.getDistrictsFromZip', :zip => zip)
        initialize_districts(response)
      end
      
      def find_by_lat_long(lat, long)
        response = fetch('districts.getDistrictFromLatLong', :latitude => lat, :longitude => long)
        initialize_districts(response)
      end
      
      def zipcodes_for_state_and_number(state, number)
        response = fetch('districts.getZipsFromDistrict', :state => state, :district => number)
        response['response']['zips']
      end
      
      private 
        def initialize_districts(response)
          results = []
          response['response']['districts'].each do |district|
            results << initialize_one(district['district'])
          end
          results          
        end
        
    end
  end
end