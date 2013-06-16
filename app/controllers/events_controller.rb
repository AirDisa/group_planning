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
