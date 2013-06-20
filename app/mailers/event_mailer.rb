class EventMailer < ActionMailer::Base
  default from: DEFAULT_FROM

  def confirmed(user, event)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @user = user
    @event = event
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "grouPACT | You're confirmed for #{@event.title}!")
  end

  def notify_creator(user, event)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @creator = user
    @event = event
    email_with_name = "#{@creator.full_name} <#{@creator.email}>"
    mail(:to => email_with_name, :subject => "grouPACT | Your event is confirmed!")
  end
end
