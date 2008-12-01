class HomeController < ApplicationController
  def index
    if logged_in?
      @missing_problems = current_user.missing_problems
      @unsolved_problems = Problem.unsolved_problems
    end
  end
end
