class ConditionsController < ApplicationController

  def new
  end

  def create
    if params[:event][:invitees] != nil
      Condition.create(:text => "min_num",
      :method => "method",
      :value => params[:event][:invitees],
      :invitee_id => params[:invitee_id])
    end

    if params[:event][:users] != nil
      params[:event][:users].each do |user|
        Condition.create(:text => "person", 
         :method => "method",
         :value => user,
         :invitee_id => params[:invitee_id])
      end           
    end
    redirect_to event_path(Event.find(Invitee.find(params[:invitee_id]).event_id).url)
  end
end
