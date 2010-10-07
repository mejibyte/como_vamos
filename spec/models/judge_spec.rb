require 'spec_helper'

describe Judge do
  before(:each) do
    @valid_attributes = {
      :name => "Valid name",
      :url => "http://valid.url.com"
    }
    
    @invalid_attributes = {
      :name => nil,
      :url => "ftp://invalid"
    }
    
  end

  it "should create a new instance given valid attributes" do
    Judge.create!(@valid_attributes)
  end
  
  it "should create an invalid instance" do
    lambda { Judge.create!(@invalid_attributes) }.should raise_error
  end
  
  it do
    Judge.create(@invalid_attributes).should have(1).error_on(:url)
  end 
  
  it do
    Judge.create(@invalid_attributes).should have(1).error_on(:name)
  end 
  
  it do
    Judge.create!(@valid_attributes).should_not have(1).problem
  end
  
  it "shoud belong to user" do
    Judge.create!(@valid_attributes).should belong_to(:owner)
  end
  
  it "should 'have_many' problems" do
    Judge.create!(@valid_attributes).should have_many(:problems)
  end
  
  
  
end

