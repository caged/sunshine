require 'rubygems'
gem 'httparty'
require 'httparty'

module Sunshine
  class Base  
    include HTTParty
    base_uri "http://services.sunlightlabs.com/api"
    attr_reader :raw_data
    class << self; attr_accessor :keys_to_exclude end
    
    def initialize(data)
      @raw_data = data
      excluded_keys = self.class.keys_to_exclude
      data.each do |key, value|
        unless !excluded_keys.nil? && excluded_keys.include?(key.to_sym)
          instance_variable_set("@#{key}", value)
          self.class.class_eval do
            define_method(key) { instance_variable_get("@#{key}") }
          end
        end
      end    
    end
    
    # If you need to define attributes that exist in the JSON data, you can exclude them from 
    # being automatically defined.
    #
    # == Example
    #  class Lobbyist < Base
    #    exclude :firstname
    #    
    #    def firstname
    #      @raw_data['firstname'].capitalize
    #    end
    #  end
    #
    def self.exclude(*keys)
      keys = keys.collect {|k| k.to_sym }.uniq
      self.keys_to_exclude = keys || []
    end

    private    
      def self.fetch(method, param_info)
        param_info = param_info.to_params if param_info.is_a?(Hash)
        begin
          get("/#{method}.json?#{param_info}&apikey=#{Sunshine.api_key}")
        rescue Net::HTTPServerException => e
          puts "#{e.response.code} ERROR: #{e.response.body_parsed}"
          return nil
        end
      end
    
      def self.initialize_one(obj)
        new(obj)
      end
    
      def self.initialize_many(results, key)
        results['response'][key].collect do |item|
          initialize_one(item)
        end
      end
  end
end