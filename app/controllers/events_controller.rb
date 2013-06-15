class EventsController < ApplicationController

  def show
    @event = Event.find_by_url(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      Invitee.create(:user_id => params[:event][:creator_id], :event_id => @event.id, :status => "Pending")
      flash[:success] = "You have created a new event!"
      CreatorMailer.event_creation(current_user, @event).deliver
      redirect_to event_path(@event.url)
    else
      flash[:error] = "Please try again"
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
