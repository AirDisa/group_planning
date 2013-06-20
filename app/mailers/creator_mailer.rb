class CreatorMailer < ActionMailer::Base
  default from: DEFAULT_FROM

  def event_creation(creator, event)
    attachments['home_logo.jpg'] = File.read('./app/assets/images/home_logo.jpg')
    @creator = creator
    @event   = event
    email_with_name = "#{@creator.full_name} <#{@creator.email}>"
    mail( :to => email_with_name,
          :subject => "You just created: #{@event.title}!")
  end

end
