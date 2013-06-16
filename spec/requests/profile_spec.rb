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

    before do
      @user  = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event)
      @invite1 = Invitee.create(:user_id => @user.id, :event_id => @event.id)

      @event2 = FactoryGirl.create(:event, :title => "New Event Title")
      @invite2 = Invitee.create(:user_id => @user.id, :event_id => @event2.id)

      @event3 = FactoryGirl.create(:event, :title => "New Event Title")
      @invite3 = Invitee.create(:user_id => @user.id, :event_id => @event3.id, :status => 'Yes')

      @event4 = FactoryGirl.create(:event, :title => "New Event Title")
      @invite4 = Invitee.create(:user_id => @user.id, :event_id => @event4.id, :status => 'No')

      user_login(@user)
      visit profile_path(@user.url)
    end

    it "should display the user's full name" do
      page.should have_content(@user.full_name)
    end

    it "should display the user's email" do
      page.should have_content(@user.email)
    end

    it "should display the user's profile pic" do
      page.should have_css('img.profile_pic')
    end

    it "should display the user's created events" do
      page.should have_content(@event.title)
    end

    it "should display the user's invited events" do
      page.should have_content(@event2.title)
    end

    it "should display pending events" do
      page.should have_content("pending:")
    end

    it "should display commited events" do
      page.should have_content("going:")
    end

    it "should display denied events" do
      page.should have_content("not going:")
    end

  end

end
