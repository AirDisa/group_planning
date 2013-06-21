class Invitee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many   :conditions
  attr_accessible :status, :user_id, :event_id, :responded, :stripe_id

  validates :user, :event, :presence => true

  def self.status_return(events, status)
    events.reject { |event| Invitee.where(:event_id => event.id, :status => status, :user_id => event.creator_id ).empty? }
  end

  def self.pending(events)
    self.status_return(events, "Pending")
  end

  def self.going(events)
    self.status_return(events, "Yes")
  end

  def self.not_going(events)
    self.status_return(events, "No")
  end

  def reset_conditions
    self.conditions.destroy_all
    self.update_attributes(:status => 'Pending', :responded => 'false')
  end

  def charge
    event = Event.find(self.event_id)
    begin
      charge = Stripe::Charge.create(
        :amount => event.down_payment,
        :currency => "usd",
        :customer => self.stripe_id,
        :description => "Paying for #{event.title} | grouPACT")
      rescue Stripe::CardError => e
        "The card has been declined"
    end
  end

end
