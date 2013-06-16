class UserMailer < ActionMailer::Base
  default from: "grouppact@gmail.com"

  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "http://groupact.heroku.com/"
    mail(:to => email_with_name, :subject => "Welcome to grouPACT!")
  end

  def event_invitee(email, creator, event)
    @user  = User.where(:email => email).first
    @event = event
    @creator = creator
    mail( :to => email, 
          :subject => "#{@creator.first_name} invited you to a grouPACT event!")
  end

end
