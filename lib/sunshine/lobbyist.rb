module Sunshine
  class Lobbyist < Base
    exclude :firstname, :lastname, :filings
    
    # I'd like to make only one call using getFilingList, but it's proving to be 
    # unreliable.
    def filings
      @filings ||= @raw_data['filings'].dup.collect do |filing|
        DisclosureFiling.find(filing)
      end
    end    
    
    def full_name
      "#{firstname} #{lastname}"
    end
    
    def firstname
      @raw_data['firstname'].capitalize
    end
    
    def lastname
      @raw_data['lastname'].capitalize
    end
    
    
    # Fuzzy name search on lobbyists
    #
    # == Examples
    #
    #    Lobbyist.search('Thompson')
    #    Lobbyist.search('Thompson', {:threshold => 0.5})
    #    Lobbyist.search('Thompson', {:year => 2008})
    # 
    # Returns an <tt>Array<tt> of <tt>[score, <Lobbyist>]<tt> results.     
    def self.search(name_query, options = {})
      options = {:name => name_query}.merge!(options)
      results = []
      year = year || Time.now.year
      names = names.join(',') if names.is_a? Array
      response = fetch('lobbyists.search', options)
      response['response']['results'].each do |item|
        results << [item['result']['score'], initialize_one(item['result']['lobbyist'])]
      end
      results
    end
  end
end