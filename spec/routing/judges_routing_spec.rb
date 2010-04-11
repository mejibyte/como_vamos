require 'spec_helper'

describe JudgesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/judges" }.should route_to(:controller => "judges", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/judges/new" }.should route_to(:controller => "judges", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/judges/1" }.should route_to(:controller => "judges", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/judges/1/edit" }.should route_to(:controller => "judges", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/judges" }.should route_to(:controller => "judges", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/judges/1" }.should route_to(:controller => "judges", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/judges/1" }.should route_to(:controller => "judges", :action => "destroy", :id => "1") 
    end
  end
end
