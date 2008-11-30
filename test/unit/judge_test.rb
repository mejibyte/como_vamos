require 'test_helper'

class JudgeTest < ActiveSupport::TestCase
  def test_invalid_with_empty_attributes
    j = Judge.new
    assert !j.valid?
    assert j.errors.invalid?(:name)
    assert j.errors.invalid?(:url)
  end
end
