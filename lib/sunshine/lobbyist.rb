module Sunshine
  class Lobbyist < Base
    exclude :firstname, :lastname
          
    # def self.search(names, year, threshold)
    #   results = []
    #   year = year || Time.now.year
    #   names = names.join(',') if names.is_a? Array
    #   response = fetch('lobbyists.search', :name => names, :year => year, :threshold => threshold)
    #   response['response']['results'].each do |item|
    #     results << [item['result']['score'], initialize_one(item['result']['lobbyist'])]
    #   end
    #   results
    # end
    
      
    def full_name
      "#{firstname} #{lastname}"
    end
    
    def firstname
      @raw_data['firstname'].capitalize
    end
    
    def lastname
      @raw_data['lastname'].capitalize
    end
  end
end