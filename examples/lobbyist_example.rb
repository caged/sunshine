require 'pp'
dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'sunshine')

Sunshine.api_key = File.read(File.join(dir, '..', '.sunlight_api_key'))

filing = Sunshine::DisclosureFiling.find('29D4D19E-CB7D-46D2-99F0-27FF15901A4C')
filing.lobbyists.each do |lob|
  puts lob.full_name
end

filing = Sunshine::DisclosureFiling.find(:first, {:client_name => 'Sunlight Foundation'})
filing.client_contact_name
#pp filing
#pp filing.raw_data['client_contact_lastname']
puts "CONTACT NAME:#{filing.client_contact_name}"
filing.lobbyists.each do |lob|
  puts "-- #{lob.full_name}"
end