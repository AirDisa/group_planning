class EventMailer < ActionMailer::Base
  default from: DEFAULT_FROM

  def charge_email(user, event)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @user = user
    @event = event
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "www.groupact.me"
    mail(:to => email_with_name, :subject => "You have been charged | grouPACT")
  end

  def confirm_email(user, event)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @user = user
    @event = event
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "www.groupact.me"
    mail(:to => email_with_name, :subject => "#{event.title} is confirmed! | grouPACT")
  end
end
