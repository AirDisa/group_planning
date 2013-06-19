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
      @user2 = FactoryGirl.create(:user2)

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

    it "should display an EDIT link if it's the current user's page" do
      page.should have_link('Edit')
    end

    it "should not have an EDIT link for another user's profile page" do
      visit profile_path(@user2.url)
      page.should_not have_link('Edit')
    end

    it "should not display a URL header if the user doesn't have one" do
      page.should_not have_content('URL:')
    end

    it "should display the user's URL if they have one" do
      visit profile_path(@user2.url)
      page.should have_link(@user2.web)
    end

    it "should display the user's written profile if they have one" do
      visit profile_path(@user2.url)
      page.should have_content(@user2.profile)
    end

    it "should display a placeholder if the is no written profile" do
      page.should have_content('You have not yet written a profile, you may do so here')
    end

    it "should have a link to add a profile if the user doesn't have one saved" do
      page.should have_link('here')
    end

  end

  context "in a user's sidebar" do
    include LoginHelpers

    before do
      @user  = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user2)

      @event = FactoryGirl.create(:event)
      @invite1 = Invitee.create(:user_id => @user.id, :event_id => @event.id)

      user_login(@user)
      visit profile_path(@user.url)
    end

    it "should display a count of invited events" do
      page.should have_content('Invited To: 1')
    end

    it "should display a list of attended events" do
      page.should have_content('Attended: 0')
    end

  end

end