require 'rubygems'
gem 'httparty'
require 'httparty'

module Sunshine
  class Base  
    include HTTParty
    
    base_uri "http://services.sunlightlabs.com/api"
    
    attr_reader :raw_data
      
    def initialize(data)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        self.class.class_eval do
          define_method(key) { instance_variable_get("@#{key}") }
        end
      end    
    end
    
    private
    
      def self.fetch(method, param_info)
        param_info = param_info.to_params if param_info.is_a?(Hash)
        begin
          get("/#{method}.json?#{param_info}&apikey=#{Sunshine.api_key}")
        rescue Net::HTTPServerException => e
          puts "#{e.response.code} ERROR: #{e.response.body_parsed}"
          return
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