class EventMailer < ActionMailer::Base
  default from: DEFAULT_FROM

  def charge_email(user, event)
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "www.groupact.com"
    mail(:to => email_with_name, :subject => "You have been charged | grouPACT!")
  end

end
