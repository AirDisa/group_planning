class Event < ActiveRecord::Base
  attr_accessible :commit_date, :creator_id, :description, :title, :image
end
