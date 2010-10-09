module StatsHelper
  def pie_chart_for_solutions
    count = {}
    Solution.all.each do |solution|
      count[solution.user] ||= 0
      count[solution.user] += 1
    end

    total = Solution.count
    data = count.collect { |user, number| number }
    labels = count.collect { |user, number| "#{user.name} (#{total == 0 ? 0 : (100.0 * number / total).round}%)" }

    Gchart.pie(:data => data, :labels => labels, :size => '695x431', :theme => :thirty7signals)
  end
end
