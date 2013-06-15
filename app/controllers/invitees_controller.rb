class InviteesController < ApplicationController

  def update
    invitee = Invitee.find(params[:id])
    @event  = Event.find(invitee.event_id)
    
    respond_to do |format|
      if invitee.update_attributes(status: params[:status], responded: true)
        going = Group.new(@event.invitees).solve
        @event.update_invitees_statuses(going)

        format.html { redirect_to event_path(@event.url) }
        format.json { respond_with_bip(@event) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@event) }
      end
    end
  end

end
