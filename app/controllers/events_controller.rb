class EventsController < ApplicationController

  def show
    @event = Event.find_by_url(params[:id])
    session[:event_id] = @event.id
    @all_comments = @event.comments
    if @event.emails.match(current_user.email) || current_user.id == @event.creator_id
      @invitee = Invitee.find_or_create_by_user_id_and_event_id(current_user.id, @event.id)
    else
      flash[:error] = "You must invited to the event to see this page"
      redirect_to :root
    end
  end

  def create
    emails = params[:event][:emails].values.delete_if {|v| v.empty?}
    params[:event][:emails] = emails.join(', ')
    params[:event][:down_payment] = (params[:event][:down_payment].to_f * 100).to_i unless params[:event][:down_payment].blank?
    @event = Event.new(params[:event])
    if @event.save!
      emails.each {|email| UserMailer.event_invitee(email, current_user, @event).deliver }
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
