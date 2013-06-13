class InviteeCondition < ActiveRecord::Base
  belongs_to :condition
  belongs_to :invitee

  validates :condition, :invitee, :presence => true
end
