class Condition < ActiveRecord::Base
  attr_accessible :method, :text, :value, :invitee_id
  belongs_to :invitee

  validates :text, :method, :value, :presence => true
end
