require 'spec_helper'

describe 'Profile Page' do

  context "with a user not logged in" do
    let(:user)  { FactoryGirl.create(:user) }

    it "should only display when a user is logged in" do
      visit profile_path(user.url)
      page.should have_content('You must be logged in to see this page')
    end

  end

  context "with a user logged in" do
    include LoginHelpers
    let(:user)  { FactoryGirl.create(:user) }
    @event = Event.create(  :creator_id   => 1,
                            :title        => 'Test Title',
                            :description  => 'Test Description',
                            :emails       => 'test@test.com')

    before(:each) do
      user_login(user)
      visit profile_path(user.url)
    end

    it "should display the user's full name" do
      page.should have_content(user.full_name)
    end

    it "should display the user's email" do
      page.should have_content(user.email)
    end

    it "should display the user's profile pic" do
      page.should have_css('img.profile_pic')
    end

    it "should display the user's created events" do
      puts page.body
      page.should have_content(@event.title)
    end

    it "should display the user's invited events"

    context "that has created events" do
      it "should display pending events"

      it "should display commited events"

      it "should display denied events"
    end

    context "that has invited events" do
      it "should display pending events"

      it "should display commited events"

      it "should display denied events"
    end

  end

end