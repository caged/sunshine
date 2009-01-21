require 'spec/spec_helper'

describe Lobbyist do
  before do
    #@lobbyists.search('Sunlight Foundation')
  end
  
  it "should exclude firstname and lastname from instance" do
    @speaker.class.keys_to_exclude.should be(['firstname', 'lastname'])
  end
end