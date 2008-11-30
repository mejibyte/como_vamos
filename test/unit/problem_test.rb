require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
  def test_invalid_with_empty_attributes
    p = Problem.new
    assert !p.valid?
    assert p.errors.invalid?(:title)
    assert p.errors.invalid?(:url)
    assert p.errors.invalid?(:number)
  end
end
