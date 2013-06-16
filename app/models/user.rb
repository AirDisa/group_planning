class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :url, :profile_pic
  has_secure_password

  acts_as_url :full_name, :sync_url => true

  has_many :invitees
  has_many :authentications
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
  validates :password,   :length     => {:minimum => 6,
                         :too_short  => "must have at least %{count} characters"}
  validates_confirmation_of :password

  mount_uploader :profile_pic, ProfilePicUploader

  def password_complexity
    if password.present? && !password.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/)
        errors.add :password, "must include at least one lowercase letter, \
                               one uppercase letter, and one digit"
    end
  end

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end

# Facebook:
#<OmniAuth::AuthHash::InfoHash
#email="mitchlee11@gmail.com"
#first_name="Mitchell"
#image="http://graph.facebook.com/579357203/picture?type=square"
#last_name="Lee"
#location="Phoenix, Arizona"
#name="Mitchell Lee"

# Google:
#<OmniAuth::AuthHash::InfoHash
#email="mitchlee11@gmail.com"
#first_name="Mitchell"
#image="https://lh3.googleusercontent.com/-ls6n5G9c-1U/AAAAAAAAAAI/AAAAAAAACyM/ccY0XRMPttQ/photo.jpg" 
#last_name="Lee"
#name="Mitchell Lee"

# Twitter:
#image="http://a0.twimg.com/profile_images/2274847204/8579ctyhgerbi6ftdoj5_normal.jpeg"
#location="Phoenix, AZ"
#name="Mitchell Lee"
#nickname="dontmitch"