class InviteeCondition < ActiveRecord::Base
  belongs_to :condition
  belongs_to :invitee
end
