class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password,
                  :password_confirmation, :url, :profile_pic, :stripe_token,
                  :web, :profile
  has_secure_password

  acts_as_url :full_name, :sync_url => true

  has_many :comments
  has_many :invitees
  has_many :events,  :through => :invitees
  has_many :created_events, :class_name => "Event", :foreign_key => :creator_id

  validates :first_name, :length     => {:minimum => 2,
                         :too_short  => "must have at least %{count} letters"}

  validates :last_name,  :length     => {:minimum => 2,
                         :too_short  => "must have at least %{count} letters"}

  validates :email,      :uniqueness => {:case_sensitive => false,
                         :message    => "has already been taken"},
                         :format     => {:with => /\w{3,}@\w+\.\w{2,3}/,
                         :message    => "must be a valid format" }

  validate  :password_complexity
  validates :password,   :presence => true, :on => :create
  validates_confirmation_of :password

  before_save { |user| user.email = user.email.downcase }

  mount_uploader :profile_pic, ProfilePicUploader

  def password_complexity
    if password.present? && !password.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}\z/)
        errors.add :password, "must include at least one lowercase letter, \
                               one uppercase letter, and one digit"
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def events_attended
    Invitee.where(:user_id => self.id, :status => "Yes").select{ |i| i.event.closed? }.map { |i| i.event }
  end
end
