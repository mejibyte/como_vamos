require 'test_helper'

class JudgeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Judge.new.valid?
  end
end
