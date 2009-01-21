require 'pp'
dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'sunshine')

Sunshine.api_key = File.read(File.join(dir, '..', '.sunlight_api_key'))

district = Sunshine::District.find_by_zipcode(97209).first
pp district.state

district = Sunshine::District.find_by_lat_long("36.234822", "-115.180664").first
pp district
pp district.zipcodes