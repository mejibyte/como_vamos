require 'test_helper'
include
class JudgeTest < ActiveSupport::TestCase
  def test_invalid_with_empty_attributes
    j = Judge.new
    assert !j.valid?
    assert j.errors.invalid?(:name)
    assert j.errors.invalid?(:url)
  end

  def test_all_sorted
    judges = Judge.all_sorted
    assert_equal(judges.size, 2)

    assert_equal(judges.first.name, "Another Test Judge")
    assert_equal(judges.last.name, "Test Judge")
  end

  def test_url_is_valid
    judge = Judge.all.first
    judge.send(:url_is_valid) # protected method, gotta do magic
    assert_equal judge.errors.size, 0
  end

  def test_url_is_invalid
    judge = Judge.new(:name => "test", :url => "foo")
    judge.send(:url_is_valid) # protected method, gotta do magic
    assert judge.errors.invalid?(:url)

    judge = Judge.new(:name => "test", :url => "http")
    judge.send(:url_is_valid) # protected method, gotta do magic
    assert judge.errors.invalid?(:url)
  end
end
