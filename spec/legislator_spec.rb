require 'spec/spec_helper'

include Sunshine

describe Legislator do
  before do
    @speaker = Legislator.find(:one, :lastname => 'pelosi')
    # @legislator = mock(@speaker)
    # @legislators = mock(:legislators)
    # 
    # @legislator.stub!(:name)
    # Legislator.stub!(:find).and_return(@speaker)
    # Legislator.stub!(:senators).and_return(@legislators)
    # Legislator.stub!(:representatives).and_return(@legislators)
  end
  
  it "should create attributes from hash" do
    @speaker.should respond_to(:firstname)
    @speaker.should respond_to(:district)
    @speaker.should respond_to(:youtube_url)
  end
  
  it "should find a legislator by zipcode" do
    legislator = Legislator.find_by_zipcode(97209)
    legislator.should have_at_least(3).legislators
  end
  
  it "should find one legislator" do
    legislator = Legislator.find(:one, :lastname => 'smith')
    legislator.should_not be_nil
  end
  
  it "should find many legislators" do
    legislators = Legislator.find(:all, :lastname => 'smith')
    legislators.should have_at_least(3).legislators
  end
  
  it "should find a scored set of search results when given a name" do
    legislators = Legislator.search('Byrd')
    legislators.should have_at_least(5).results
    legislators.first[0].should == 1.0
    legislators.last[0].should be < 1.0
  end
  
  it "should find legislators when given a string with multiple paramaters of the same name" do
    legislators = Legislator.find(:all, "lastname=Byrd&lastname=Paul")
    legislators.first.full_name.should == "Robert Byrd"
    legislators.last.full_name.should == "Ronald Paul"
  end
  
  it "should combine first and last name to make full name" do
    @speaker.full_name.should == "Nancy Pelosi"
  end
end