require 'spec_helper'

describe 'User' do

  context 'create' do

    it 'should create a new user' do
      expect { FactoryGirl.create(:user) }.to change(User, :count).by(1)
    end

    it 'should require a username >= 4 characters' do
      FactoryGirl.build(:user, :username => 'bro').should_not be_valid
    end

    it 'should require an email' do
      FactoryGirl.build(:user, :email => '').should_not be_valid
    end

    it 'should require a valid email' do
      FactoryGirl.build(:user, :email => 'bs_email_at_crap.com').should_not be_valid
    end

    it 'should verify uniqueness of email' do
      FactoryGirl.create(:user)
      FactoryGirl.build(:user, :username => 'paulwalker').should_not be_valid
    end

    it 'should verify uniqueness of username' do
      FactoryGirl.create(:user)
      FactoryGirl.build(:user, :email => 'pwalker@att.bro').should_not be_valid
    end

    it 'should require password confirmation' do
      FactoryGirl.build(:user, :password_confirmation => 'asdfasdf').should_not be_valid
    end

    it 'should require a password >= 6 characters' do
      FactoryGirl.build(:user,
                        :password => 'brahs',
                        :password_confirmation => 'brahs').should_not be_valid
    end

  end
end
