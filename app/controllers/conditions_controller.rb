class ConditionsController < ApplicationController

  def new
  end

  def create
    Condition.create(:text => "min_num",
                     :method => "method",
                     :value => params[:event][:invitees],
                     :invitee_id => params[:invitee_id])

    params[:event][:users].each do |user|
    Condition.create(:text => "person", 
                               :method => "method",
                               :value => user,
                               :invitee_id => params[:invitee_id])
    end           
      redirect_to event_path(Event.find(Invitee.find(params[:invitee_id]).event_id).url)
  end
end
