require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
  def test_invalid_with_empty_attributes
    p = Problem.new
    assert !p.valid?
    assert p.errors.invalid?(:title)
    assert p.errors.invalid?(:url)
    assert p.errors.invalid?(:number)
  end

  def test_full_title
    title = Problem.first.full_title
    assert_equal title, "1 - A Problem"
  end

  def test_solved
    assert !Problem.first.solved?
  end

  def test_solved_by
    assert !Problem.first.solved_by?(1)
  end

  def test_unsolved_problems
    problems = Problem.unsolved_problems
    assert_equal problems, Problem.all
  end
end
