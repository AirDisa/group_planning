class MailPreview < MailView

  def welcome_email
    UserMailer.welcome_email(User.last)
  end

  def event_invitee
    event = Event.last
    event.update_attribute("down_payment", nil)
    UserMailer.event_invitee("mitch@gmail.com", event.creator, event)
  end

  def event_invitee_with_money
    event = Event.last
    event.update_attribute("down_payment", 1000)
    UserMailer.event_invitee("mitch@gmail.com", Event.last.creator, Event.last)
  end

  def event_creation
    event = Event.last
    event.update_attribute("down_payment", nil)
    CreatorMailer.event_creation(event.creator, event)
  end

  def event_creation_with_money
    event = Event.last
    event.update_attribute("down_payment", 1000)
    CreatorMailer.event_creation(event.creator, event)
  end

  def confirmed
    event = Event.last
    event.update_attribute("down_payment", 1000)
    EventMailer.confirmed(event.invitees.sample.user, event)
  end

  def notify_creator
    event = Event.last
    event.update_attribute("down_payment", 1000)
    EventMailer.notify_creator(event.creator, event)
  end
end
