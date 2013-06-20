class UserMailer < ActionMailer::Base
  default from: DEFAULT_FROM

  def welcome_email(user)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @user = user
    email_with_name = "#{@user.full_name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "Welcome to grouPACT!")
  end

  def event_invitee(email, creator, event)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @user  = User.where(:email => email).first
    @event = event
    @creator = creator
    mail( :to => email,
          :subject => "#{@creator.first_name} invited you to a grouPACT event!")
  end

  # Needs to be implemented tested!
  # def calendar_reminder(user, event)
  #   @user  = user
  #   @event = event
  #   mail( :to => @user.email,
  #         :subject => "You are now confirmed for #{@event.title}!") do |format|
  #      format.ics {
  #      ical = Icalendar::Calendar.new
  #      ical.add_event(@event.to_ics)
  #      ical.publish
  #      ical.to_ical
  #      render :text => ical, :layout => false
  #     }
  #   end
  # end

end
