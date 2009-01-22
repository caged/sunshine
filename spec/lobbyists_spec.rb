require 'spec/spec_helper'
include Sunshine

describe Lobbyist do
  before do
    @lobbyists = Lobbyist.search('William Corr')
  end
  
  it "should find lobbyists" do
    score = @lobbyists.first[0]
    lobbyist = @lobbyists.first[1]
    
    score.should == 1.0
    lobbyist.should be_instance_of(Lobbyist)
  end
  
  it "should lazily load filings" do
    lobbyist = @lobbyists.first[1]
    
    filing_var = lobbyist.send(:instance_variable_get, "@filings")
    filing_var.should be(nil)
    
    filings = lobbyist.filings
    filings.first.should be_instance_of(DisclosureFiling)
    
    filing_var = lobbyist.send(:instance_variable_get, "@filings")
    filing_var.should_not == nil
  end
  
  it "should exclude keys from instance" do
    Lobbyist.keys_to_exclude.should == [:firstname, :lastname, :filings]
  end
end