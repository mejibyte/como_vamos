# -*- coding: utf-8 -*-
class MailOffice < ActionMailer::Base


  def test_mail(address, name, sent_at = Time.now)
    recipients address
    subject "Test message"
    from "¿Cómo vamos? <comovamos@factorcomun.org>"
    sent_on sent_at

    body :name => name
  end


  # This is the real message that should be sent. But it's not being called yet.
  def new_solution(user, solution, solution_url, site_url, sent_at = Time.now)
    recipients user.email
    subject    "[¿Cómo vamos?] New problem solved!"
    from       "comovamos@factorcomun.org"
    sent_on    sent_at

    body       :site_url      => site_url,
               :solution_url  => solution_url,
               :solver        => solution.user,
               :problem       => solution.problem,
               :you_solved_it => user.solved_problems.include?(solution.problem),
               :user          => user,
               :judge         => solution.problem.judge
  end

end