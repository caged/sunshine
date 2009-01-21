module Sunshine
  class DisclosureFiling < Base
    exclude :lobbyists
    
    def lobbyists
      @raw_data['lobbyists'].collect do |lb|
        Lobbyist.new(lb['lobbyist'])
      end
    end
    
    class << self
      def find(*args)
        if args.first.is_a?(String)
          response = fetch('lobbyists.getFiling', {:id => args.first})
          return initialize_one(response['response']['filing'])
        end
      end
    end
  end
end