class UserMailer < ActionMailer::Base
  default from: "notifications@groupact.it"

  def welcome_email(user)
    @user = user
    @url  = "http://groupact.heroku.com/"
    mail(:to => user.email, :subject => "Welcome to grouPACT!")
  end

end
