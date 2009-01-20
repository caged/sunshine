module Sunshine
  class Legislator < Base
    
    def full_name
      "#{firstname} #{lastname}"
    end
    
    class << self
      def senators
        find(:all, :title => 'Sen')
      end
    
      def representatives
        find(:all, :title => 'Rep')
      end
    
      def search(query)
        results = []
        response = fetch('legislators.search', {:name => query})
        response['response']['results'].each do |item|
          results << [item['result']['score'], initialize_one(item['result']['legislator'])]
        end
        results
      end
    
      def find(amount, params)
        legislators = []
        response = fetch('legislators.getList', params) 
        if response
          legislators = initialize_legislators(response)
        end
        return legislators.first if amount == :one
        legislators
      end
    
      def find_by_zipcode(zipcode)
        response = fetch('legislators.allForZip', {:zip => zipcode})
        initialize_legislators(response)
      end
      
      def find_by_lat_long(lat, long)
        districts = District.find_by_lat_long(lat, long)
        state = districts.first.state
        url_parts = ["state=#{state}"]
        districts.each do |district|
          url_parts << "district=#{district.number}"
        end
        senators = find(:all, url_parts.first)
        reps = find(:all, url_parts.join("&"))
        [senators, reps].flatten
      end
    
      private
    
        def initialize_legislators(response)
          response['response']['legislators'].collect do |legislator|
            initialize_one(legislator['legislator'])
          end
        end
    end
  end
end