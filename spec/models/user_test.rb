require 'spec_helper'

describe 'User' do

  context 'create' do

    it 'should create a new user' do
      expect { FactoryGirl.create(:user) }.to change(User, :count).by(1)
    end

    it 'should require a first_name' do
      FactoryGirl.build(:user, :first_name => '').should_not be_valid
    end

    it 'should require a first_name with at least 3 characters' do
      FactoryGirl.build(:user, :first_name => 'Abe').should_not be_valid
    end

    it 'should require a last_name' do
      FactoryGirl.build(:user, :first_name => '').should_not be_valid
    end

    it 'should require a last_name with at least 3 characters' do
      FactoryGirl.build(:user, :first_name => 'Lee').should_not be_valid
    end

    it 'should require an email' do
      FactoryGirl.build(:user, :email => '').should_not be_valid
    end

    it 'should require a valid email' do
      FactoryGirl.build(:user, :email => 'invalid-email.com').should_not be_valid
    end

    it 'should verify uniqueness of email' do
      FactoryGirl.create(:user)
      FactoryGirl.build(:user, :first_name => 'Jane').should_not be_valid
    end

    it 'should require a secure password' do
      FactoryGirl.build(:user,
                        :password => 'secret',
                        :password_confirmation => 'secret').should_not be_valid
    end

    it 'should require password confirmation' do
      FactoryGirl.build(:user, :password_confirmation => 'secret').should_not be_valid
    end

  end
end
