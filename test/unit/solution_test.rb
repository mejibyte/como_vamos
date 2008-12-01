require 'test_helper'

class SolutionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Solution.new.valid?
  end
end
