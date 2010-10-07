require 'spec_helper'

describe "/judges/edit.html.erb" do
  include JudgesHelper

  before(:each) do
    assigns[:judge] = @judge = stub_model(Judge,
      :new_record? => false
    )
  end

  it "renders the edit judge form" do
    render

    response.should have_tag("form[action=#{judge_path(@judge)}][method=post]") do
    end
  end
end
