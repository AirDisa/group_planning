class Condition < ActiveRecord::Base
  attr_accessible :method, :value, :invitee_id
  belongs_to :invitee

  validates :method, :value, :presence => true
end
