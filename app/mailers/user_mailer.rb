class UserMailer < ActionMailer::Base
  default from: "notifications@groupact.it"

  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "http://groupact.heroku.com/"
    mail(:to => email_with_name, :subject => "Welcome to grouPACT!")
  end

  def event_signup(user)
    # @user  = user
    # email_with_name = "#{@user.full_name} <#{@user.email}>"
    # @url  = "http://groupact.heroku.com/"
    # mail(:to => email_with_name, :subject => "Thanks for signing up!")
  end

end
