require 'test_helper'

class StatsHelperTest < ActionView::TestCase
  def test_pie_chart_for_solutions
    s = pie_chart_for_solutions
    assert s =~ /http:\/\/chart.apis.google.com\/chart/
  end
end
