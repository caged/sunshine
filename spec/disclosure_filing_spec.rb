require 'spec/spec_helper'

include Sunshine

describe DisclosureFiling do
  before do
    @disclosure = DisclosureFiling.find("29D4D19E-CB7D-46D2-99F0-27FF15901A4C")
  end
  
  it "should find a disclosure when given an id" do
    @disclosure.should be_instance_of(DisclosureFiling)
  end
  
  it "should find a disclosure when given a client name" do
    disclosure = DisclosureFiling.find(:first, {:client_name => 'Sunlight Foundation'})
    disclosure.should be_instance_of(DisclosureFiling)
  end
  
  it "should return nil if a client name and recipient name are both given" do
    disclosure = DisclosureFiling.find(:first, {:client_name => 'Sunlight Foundation', :recipient_name => 'Sunlight Foundation'})
    disclosure.should_not be(nil)
  end
  
  it "should initialize lobbyists for a filing" do
    lobbyists = @disclosure.lobbyists
    lobbyists.first.should be_instance_of(Lobbyist)
  end
  
  it "should compose client contact name from firstname and lastname" do
    firstname = @disclosure.raw_data['client_contact_firstname'].capitalize
    lastname = @disclosure.raw_data['client_contact_lastname'].capitalize
    
    @disclosure.client_contact_name.should == "#{firstname} #{lastname}"
  end
end