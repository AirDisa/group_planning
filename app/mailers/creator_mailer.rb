class CreatorMailer < ActionMailer::Base
  default :to   => User,
          :from => "notifications@groupact.it"

  def event_creation(creator, event)
    @creator = creator
    @event   = event
    email_with_name = "#{@creator.full_name} <#{@creator.email}>"
    mail( :to => email_with_name,
          :subject => "You just created #{@event.title}!")
  end

end
