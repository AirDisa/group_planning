class Event < ActiveRecord::Base
 
  acts_as_url :title
  attr_accessible :commit_date, :creator_id, :description, :title, :image
  has_many :invitees
  belongs_to :creator, :class_name => "User"
  has_many :users, :through => :invitees
  mount_uploader :image, ImageUploader
  
  validates :title,       :length => {:minimum => 4,
                          :too_short => "must have at least %{count} letters"}
  validates :creator_id,  :presence => true
  validates :commit_date, :presence => true
  validate  :commit_date_is_in_the_future

  def waffling
    invitees.select { |invitee| invitee.status == "Pending" }
  end

  def going
    invitees.select { |invitee| invitee.status == "Yes" }
  end

  def not_going
    invitees.select { |invitee| invitee.status == "No" }
  end

  private

  def commit_date_is_in_the_future
    if commit_date && commit_date < DateTime.now
      errors.add(:commit_date, "must be in the future")
    end
  end
end

