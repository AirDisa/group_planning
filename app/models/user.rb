class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :first_name, :last_name, :password_digest
  has_many :invitees
  has_many :events,  :through     => :invitees
  has_many :events,  :foreign_key => :creator_id

  validates :first_name, :presence => true, :length => {:minimum => 3}
  validates :last_name,  :presence => true, :length => {:minimum => 3}
  validates :email,      :uniqueness => {:case_sensitive => false}, 
                         :format => /\w+@\w+\.\w{2,3}/
  validate  :password_complexity
  validates_confirmation_of :password

  def password_complexity
    if password.present? && !password.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/)
        errors.add :password, "must include at least one lowercase letter, \
                               one uppercase letter, and one digit"
    end
  end
end
