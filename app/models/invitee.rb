class Invitee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many   :conditions
  attr_accessible :status, :user_id, :event_id

  validates :user, :event, :status, :presence => true
end
