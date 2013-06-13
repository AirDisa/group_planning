class EventsController < ApplicationController

  def show
    @event = Event.find_by_url(params[:slug])
  end

end
