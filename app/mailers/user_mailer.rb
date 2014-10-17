class UserMailer < ActionMailer::Base
  default from: "notifications@memorygame-demo.herokuapp.com"
  def notify_email(email_id, url)
    # Check if the url is valid

    if (email_id =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i && url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix)
      @url  = url
      mail(to: email_id, subject: 'Thank you for playing Memory Game Demo')
      return true
    else
      return false
    end
  end
end
