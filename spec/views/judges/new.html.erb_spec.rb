require 'spec_helper'

describe "/judges/new.html.erb" do
  include JudgesHelper

  before(:each) do
    assigns[:judge] = stub_model(Judge,
      :new_record? => true
    )
  end

  it "renders new judge form" do
    render

    response.should have_tag("form[action=?][method=post]", judges_path) do
    end
  end
end
