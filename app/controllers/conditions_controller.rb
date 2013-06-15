class ConditionsController < ApplicationController

  def new
  end

  def create
    @event = Event.find(params[:event_id])

    if params[:event][:invitees]
      Condition.create( :method     => "required_count",
                        :value      => params[:event][:invitees],
                        :invitee_id => params[:invitee_id])
    end

    if params[:event][:users]
      params[:event][:users].each do |user_id|
        Condition.create(:method     => "specific_person",
                         :value      => user_id,
                         :invitee_id => params[:invitee_id])
      end
    end

    @invitee = Invitee.find(params[:invitee_id]).update_attributes(responded: true)
    puts "\n\n\n\n"
    p @invitee.responded
    going = Group.new(@event.invitees).solve
    @event.update_invitees_statuses(going)
    
    redirect_to event_path(@event.url)
  end
end
