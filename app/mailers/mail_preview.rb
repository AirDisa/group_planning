class MailPreview < MailView

  def welcome_email
    UserMailer.welcome_email(User.last)
  end

  def confirm_event
    UserMailer.confirm_event(User.last, Event.last)
  end

  def event_invitee
    UserMailer.event_invitee("mitch@gmail.com", Event.last.creator, Event.last)
  end

  def event_creation
    CreatorMailer.event_creation(Event.last.creator, Event.last)
  end
end