require 'test_helper'

class SolutionTest < ActiveSupport::TestCase
  def test_should_not_be_valid
    assert !Solution.new.valid?
  end
end
