class ConditionsController < ApplicationController

  def new
  end

  def create
    Condition.create(:text => "min_num",
                     :method => "method",
                     :value => params[:event][:invitees],
                     :invitee_id => params[:event_id])

    params[:event][:users].each do |user|
    @condition = Condition.create(:text => "person", 
                               :method => "method",
                               :value => user,
                               :invitee_id => params[:event_id])
    end           
      redirect_to event_path(Event.find(params[:event_id]).url)
  end
end
