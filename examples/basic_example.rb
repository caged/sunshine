require 'pp'
dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'sunshine')

Sunshine.api_key = File.read(File.join(dir, '..', '.sunlight_api_key'))

reprezintin = Sunshine::Legislator.find(:all, {:title => 'Rep'})
reprezintin.each do |homeslice|
  puts "#{homeslice.full_name}: #{homeslice.state}'s #{homeslice.district}"
end

many_dudes = Sunshine::Legislator.search('smith')
many_dudes.each do |score, leg|
  puts leg.full_name
end

zipdudes = Sunshine::Legislator.find_by_zipcode(97209)
zipdudes.each do |dude|
  puts dude.full_name
end

democrats = Sunshine::Legislator.find(:all, :party => 'D')
pp Sunshine::Legislator.find(:one, :firstname => 'nancy')

legislators = Sunshine::Legislator.find_by_lat_long("36.234822", "-115.180664")
legislators.each do |l|
  puts l.full_name
end
