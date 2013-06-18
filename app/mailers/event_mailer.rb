class EventMailer < ActionMailer::Base
  default to: User,
          from: DEFAULT_FROM

  def charge_email(user, event)
    @user = user
    @event = event
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "www.groupact.com"
    mail(:to => email_with_name, :subject => "You have been charged | grouPACT")
  end

  def confirm_email(user, event)
    @user = user
    @event = event
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "www.groupact.com"
    mail(:to => email_with_name, :subject => "#{event.title} is confirmed! | grouPACT")
  end
end
