require 'spec/spec_helper'

include Sunshine
  
describe District do
  before do
    @districts = District.find_by_zipcode(97209)
  end
  
  it "should find a district by a zip code" do
    @districts.should have_at_least(1).district
    @districts.first.state.should == "OR"
  end
  
  it "should have an associated set of zip codes" do
    @districts.first.zipcodes.should have_at_least(1).zipcode
  end
  
  it "should find a district at a specific latitude and longitude" do
    district = District.find_by_lat_long("36.234822", "-115.180664").first
    district.state.should == "NV"
  end
end