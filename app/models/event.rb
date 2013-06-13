class Event < ActiveRecord::Base
 
  acts_as_url :title
  attr_accessible :commit_date, :creator_id, :description, :title, :image
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  has_many :invitees
  has_many :users, :through => :invitees
  mount_uploader :image, ImageUploader
  
  validates :title,       :length => {:minimum => 4,
                          :too_short => "must have at least %{count} letters"}
  validates :creator_id,  :presence => true
  validates :commit_date, :presence => true
  validate  :commit_date_is_in_the_future

  private

  def commit_date_is_in_the_future
    if commit_date && commit_date < DateTime.now
      errors.add(:commit_date, "must be in the future")
    end
  end
end
