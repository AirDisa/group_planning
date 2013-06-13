class Invitee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  attr_accessible :status

  validates :user, :event, :status, :presence => true
end
