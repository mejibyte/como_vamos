require 'spec_helper'

describe "/judges/index.html.erb" do
  include JudgesHelper

  before(:each) do
    assigns[:judges] = [
      stub_model(Judge),
      stub_model(Judge)
    ]
  end

  it "renders a list of judges" do
    render
  end
end
