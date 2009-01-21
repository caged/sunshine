module Sunshine
  class DisclosureFiling < Base
    exclude :lobbyists, :client_contact_firstname, :client_contact_lastname
    
    def client_contact_name
      "#{client_contact_firstname} #{client_contact_lastname}"
    end
    
    def client_contact_firstname
      @raw_data['client_contact_firstname'].capitalize
    end
    
    def client_contact_lastname
      @raw_data['client_contact_lastname'].capitalize
    end
    
    def lobbyists
      @raw_data['lobbyists'].collect do |lb|
        Lobbyist.new(lb['lobbyist'])
      end
    end
    
    class << self
      # Get a disclosure filing
      #
      # This wraps all of Sunlights lobbyist methods into a single convenient method.
      #
      # == Examples
      #
      #   # Find by filing id
      #   Disclosure.find(filing_id)
      #   Disclosure.find("29D4D19E-CB7D-46D2-99F0-27FF15901A4C")
      #
      #  # Find by clinet_name or registrant_name.  One of these parameters 
      #  # must be present
      #  Disclosure.find(:all, :client_name => 'Sunlight Foundation')
      #  Disclosure.find(:all, :registrant_name => 'Sunlight Foundation')
      #  Disclosure.find(:first, :client_name => 'Sunlight Foundation')
      #
      def find(*args)
        results = []
        # search by filing id
        arguments = args.dup
        if arguments.first.is_a?(String)
          response = fetch('lobbyists.getFiling', {:id => arguments.first})
          results = initialize_one(response['response']['filing'])
        else
          amount = arguments.shift
          arguments = arguments.first
          params = {}
          params.merge!(:year => arguments[:year]) if arguments[:year]
          params.merge!(:client_name => arguments[:client_name]) if arguments[:client_name]
          params.merge!(:registrant_name => arguments[:registrant_name]) if arguments[:registrant_name]
          response = fetch('lobbyists.getFilingList', params)
          if response
            if amount == :first
              filing = response['response']['filings'].first
              return initialize_one(filing['filing']) if filing
            elsif amount == :all
              return response['response']['filings']
            end
          end
        end
      end
    end
  end
end