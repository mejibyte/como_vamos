require 'spec_helper'

describe "/judges/show.html.erb" do
  include JudgesHelper
  before(:each) do
    assigns[:judge] = @judge = stub_model(Judge)
  end

  it "renders attributes in <p>" do
    render
  end
end
