class UserMailer < ActionMailer::Base
  default from: "notifications@memorygame-demo.herokuapp.com"
  def notify_email(email_id, url)
    @url  = url
    mail(to: email_id, subject: 'Thank you for playing Memory Game Demo')
  end
end
