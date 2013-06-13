class Invitee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many   :conditions
  attr_accessible :status

  validates :user, :event, :status, :presence => true
end
