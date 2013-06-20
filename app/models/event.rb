class Event < ActiveRecord::Base
  attr_accessible :commit_date, :creator_id, :description, :title, :image,
                  :emails, :down_payment, :creator_api, :start_time
  acts_as_url :title
  acts_as_commentable

  has_many :invitees
  belongs_to :creator, :class_name => "User"
  has_many :users, :through => :invitees
  # mount_uploader :image, ImageUploader

  validates :title,       :length => {:minimum => 4,
                          :too_short => "must have at least %{count} letters"}
  validates :creator_id,  :presence => true
  validates :emails,      :length => {:minimum => 6,
                          :too_short => "must include at least one invitee"}
  validates :commit_date, :presence => true
  validate  :commit_date_is_in_the_future
  validate  :event_date_is_after_commit_date
  validates :down_payment, :format => {:with => /^\d{1,}$/}, :allow_nil => true

  def waffling
    invitees.select { |invitee| invitee.status == "Pending" }
  end

  def waffling_by_user(user_id)
    waffling.select { |invitee| invitee.user_id == user_id }
  end

  def going
    invitees.select { |invitee| invitee.status == "Yes" }
  end

  def not_going
    invitees.select { |invitee| invitee.status == "No" }
  end

  def update_invitees_statuses(going)
    invitees.each { |invitee| invitee.update_attribute("status", "Pending") if invitee.status == "Yes" }
    going.each    { |invitee| invitee.update_attribute("status", "Yes") }
  end

  def to_ics
    cal = Icalendar::Event.new
    cal.start = DateTime.now.strftime("%Y%m%dT%H%M%S")
    cal.end = (DateTime.now+1.day).strftime("%Y%m%dT%H%M%S")
    cal.summary = self.title
    cal.description = self.description
    cal.klass = "PUBLIC"
    cal.created = self.created_at
    cal.last_modified = self.updated_at
    cal.uid = cal.url = "http://groupact.me/events/#{self.url}"
    cal
  end

  def start_time=(params)
    if params
      write_attribute :start_time, DateTime.parse(params['date'] + ' ' + params['time']) + 5.hours
    end
  end

  def commit_date=(date)
    if date
      date = Time.parse(date)
      write_attribute :commit_date, Time.new(date.year, date.month, date.day, 23, 59, 59, "-05:00")
    end
  end

  def self.closeout_all_expired
    self.where('settled IS NULL AND commit_date < ?', Time.now).each do |event|
      event.update_invitees_statuses(Group.new(event.invitees).solve)
      event.settle_event
    end
  end

  def settle_event
    down_payment ? settle_with_payment : settle_without_payment
    self.update_attribute("settled", true)
  end

  def settle_with_payment
    invitees.each do |invitee|
      if invitee.user_id == self.creator_id
        EventMailer.notify_creator(invitee.user, event).deliver
      elsif invitee.status == "Yes"
        invitee.charge
        EventMailer.confirmed(invitee.user, event).deliver
      end
    end
  end

  def settle_without_payment
    invitees.each do |invitee|
      EventMailer.confirmed(invitee.user, event).deliver
    end
  end

  def settle_event
    self.update_attribute("settled", true)
  end

  def closed?
    commit_date < Time.now
  end

  private

  def commit_date_is_in_the_future
    if commit_date && closed?
      errors.add(:commit_date, "must be in the future")
    end
  end

  def event_date_is_after_commit_date
    if start_time && start_time < commit_date
      errors.add(:start_time, "must be after commit date")
    end
  end
end
