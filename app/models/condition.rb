class Condition < ActiveRecord::Base
  attr_accessible :method, :text, :value

  validates :text, :method, :value, :presence => true
end
