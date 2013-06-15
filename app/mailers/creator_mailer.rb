class CreatorMailer < ActionMailer::Base
  default :to   => User,
          :from => "notifications@groupact.it"

  def event_creation(creator, event)
    # @creator = creator
    # @event   = event
    # email_with_name = "#{@creator.full_name} <#{@creator.email}>"
    # mail( :to => email_with_name,
    #       :subject => "You just created #{@event.title}!")
  end

  def event_signup(creator, event, user)
    # @creator = creator
    # @event   = event
    # @user  = user
    # email_with_name = "#{@user.full_name} <#{@user.email}>"
    # @url  = "http://groupact.heroku.com/"
    # mail(:to => email_with_name,
          #:subject => "#{@user.first_name} just signed up for #{@event.title}!")
  end
end
