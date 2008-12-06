# -*- coding: utf-8 -*-
class MailOffice < ActionMailer::Base


  def test_mail(address, name, site_url, sent_at = Time.now)
    # This method won't be called since the route was turned off.
    # This was only used for checking the SMTP server.

    recipients address
    subject "Test message"
    from "¿Cómo vamos? <comovamos@factorcomun.org>"
    sent_on sent_at

    body :name => name, :url => site_url
  end


  # This is the real message that should be sent. But it's not being called yet.
  def new_solution(address_book, solution, solution_url, site_url, sent_at = Time.now)
    bcc        address_book
    subject    "[¿Cómo vamos?] New problem solved!"
    from       "comovamos@factorcomun.org"
    sent_on    sent_at

    body       :site_url      => site_url,
               :solution_url  => solution_url,
               :solver        => solution.user,
               :problem       => solution.problem,
               :judge         => solution.problem.judge
  end

end
