class InviteesController < ApplicationController

  def update
    @invitee = Invitee.find(params[:id])
    respond_to do |format|
      if @invitee.update_attribute("status", params[:status])
        format.html { redirect_to event_path(Event.find(@invitee.event_id).url) }
        format.json { respond_with_bip(@event) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@event) }
      end
    end
  end

end
