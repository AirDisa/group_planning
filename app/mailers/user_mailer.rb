class UserMailer < ActionMailer::Base
  default to:   User,
          from: DEFAULT_FROM

  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    @url  = "www.groupact.me"
    mail(:to => email_with_name, :subject => "Welcome to grouPACT!")
  end

  def event_invitee(email, creator, event)
    @user  = User.where(:email => email).first
    @event = event
    @creator = creator
    mail( :to => email,
          :subject => "#{@creator.first_name} invited you to a grouPACT event!")
  end

  # Needs to be tested!
  def confirm_event(user, event)
    @user  = user
    @event = event
    mail( :to => @user.email,
          :subject => "You are now confirmed for #{@event.title}!") do |format|
       format.ics {
       ical = Icalendar::Calendar.new
       ical.add_event(@event.to_ics)
       ical.publish
       ical.to_ical
       render :text => ical, :layout => false
      }
    end
  end

end
