require 'spec_helper'

describe User do

  it { should be_instance_of(User) }

  it { should ensure_length_of(:first_name).is_at_least(2).
              with_message(/must have at least 2 letters/) }
  it { should ensure_length_of(:last_name).is_at_least(2).
              with_message(/must have at least 2 letters/) }

  it { should allow_value("abc@def.com").for(:email) }
  it { should_not allow_value("bad_email.com", "ab@cd.com").for(:email) }
  it "validates uniqueness of email" do
    user = User.new(:first_name => 'A', :last_name => 'B', :email => 'C')
    user.password_digest = 'D'
    user.save!(:validate => false)

    should validate_uniqueness_of(:email).case_insensitive
  end

  it { should validate_confirmation_of(:password) }
  it { should allow_value("Password1", "passW0rd").for(:password) }
  it { should_not allow_value("password", "Password", "passw0rd", "Pa1").for(:password) }

  it { should have_many(:invitees) }
  it { should have_many(:events) }
  it { should have_many(:created_events) }
  it { should have_many(:comments) }

  it { should allow_value("user-slug").for(:url) }

  it { should allow_value("/assets/images/test.png").for(:profile_pic) }
  it { should allow_value("www.twitter.com/test").for(:web) }
  it { should allow_value('This is a test bio. This will be used solely for rspec
                           testing and nothing else.').for(:profile)}
  it { should allow_value("ac_22AAaAaaaA0AAaAA0aAaaAAaAaa5aaaa").for(:stripe_token)}

  context 'user model method' do

  before(:each) do
      @user   = FactoryGirl.create(:user)
      @event  = FactoryGirl.create(:event)
      @event_one  = FactoryGirl.build(:event_one)
      @invitee = Invitee.create(:user_id => @user.id, :event_id => @event.id, :status =>"Yes")
      @invitee_one = Invitee.create(:user_id => @user.id, :event_id => @event_one.id, :status =>"Yes") 
    end

    it 'should concact the first and last name' do
      "#{@user.first_name} #{@user.last_name}" == @user.full_name
    end

    it 'should know which event user has attended' do
      @user.events_attended == @invitee_one
    end
  end
end
