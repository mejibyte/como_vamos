# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  def index
    if logged_in?
      @missing_problems = current_user.missing_problems
      @unsolved_problems = Problem.unsolved_problems
      @solved_problems = current_user.solved_problems
    end
  end

  def test_email
    # This method won't be called since the route was turned off.
    # This was only used for checking the SMTP server.
    MailOffice.deliver_test_mail("andmej@gmail.com", "Andrés Mejía", root_url)
    MailOffice.deliver_test_mail("sebastianarcila@gmail.com", "Sebastián Arcila", root_url)
    redirect_to root_path
  end
end
