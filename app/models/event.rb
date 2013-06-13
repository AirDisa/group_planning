class Event < ActiveRecord::Base
 
  acts_as_url :title

  attr_accessible :commit_date, :creator_id, :description, :title, :image
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id

  validates :title,      :presence => true, :length => {:minimum => 4}
  validates :creator_id, :presence => true

end
