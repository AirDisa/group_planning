class EventsController < ApplicationController

  def show
    @event = Event.find_by_url(params[:id])
    if @event.emails.match(current_user.email) || current_user.id == @event.creator_id
      @invitee = Invitee.find_or_create_by_user_id_and_event_id(current_user.id, @event.id)
    else
      flash[:error] = "You must invited to the event to see this page"
      redirect_to :root
    end
  end

  def create
    params[:event][:emails] = params[:event][:emails].map(&:last).join(', ')
    @event = Event.new(params[:event])
    if @event.save
      CreatorMailer.event_creation(current_user, @event).deliver
      flash[:success] = "Your new event was created successfully!"
      redirect_to event_path(@event.url)
    else
      flash[:error] = "An error occured while trying to make the event"
      redirect_to :back
    end
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to event_path(@event) }
        format.json { respond_with_bip(@event) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@event) }
      end
    end
  end
end

###
# Sample Google Calendar integration
###
# def create
#   @event = Event.new(params[:event])
#   respond_to do |format|
#   if @event.save
#     email = @event.attendees.split(",")
#     new_array = []
#     email.each do |mail|
#     new_array << { "email" => mail }
#   end
#   user = current_user
#   event = { 'summary' => @event.summary,
#             'location' => @event.location,
#             'start' => { 'dateTime' => @event.start_date_time.to_datetime.rfc3339},
#             'end' => { 'dateTime' => @event.end_date_time.to_datetime.rfc3339},
#             'attendees' => new_array }

# #Use the token from the data to request a list of calendars token = user["token"]
#   client  = Google::APIClient.new
#   client.authorization.access_token = token
#   service = client.discovered_api('calendar', 'v3')
#   result  = client.execute(:api_method => service.events.insert,
#                            :parameters => {'calendarId' => 'primary'},
#                            :body => JSON.dump(event),
#                            :headers => {'Content-Type' => 'application/json'})
#   format.html { redirect_to @event, notice: 'Event was successfully created.'}
#   format.json { render json: @event, status: :created, location: @event }
# else
#   format.html { render action: "new" }
#   format.json { render json: @event.errors, status: :unprocessable_entity }
# end