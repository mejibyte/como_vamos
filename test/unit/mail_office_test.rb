require 'test_helper'

class MailOfficeTest < ActionMailer::TestCase
  tests MailOffice
  def test_new_solution
    @expected.subject = 'MailOffice#new_solution'
    @expected.body    = read_fixture('new_solution')
    @expected.date    = Time.now

    assert_equal @expected.encoded, MailOffice.create_new_solution(@expected.date).encoded
  end

end
