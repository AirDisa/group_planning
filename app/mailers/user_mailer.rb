class UserMailer < ActionMailer::Base
  default from: DEFAULT_FROM

  def welcome_email(user)
    attachments['logo.jpg'] = File.read('./app/assets/images/logo_500_100.jpg')
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "Welcome to grouPACT!")
  end

  def event_invitee(email, creator, event)
    attachments['logo.jpg'] = File.read('./app/assets/images/logo_500_100.jpg')
    @user  = User.where(:email => email).first
    @event = event
    @creator = creator
    mail( :to => email,
          :subject => "#{@creator.first_name} invited you to a grouPACT event!")
  end
end
