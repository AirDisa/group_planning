class Invitee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many   :conditions
  attr_accessible :status, :user_id, :event_id, :responded

  validates :user, :event, :status, :responded, :presence => true

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

end
