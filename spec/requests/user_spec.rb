require 'spec_helper'

describe 'User' do
  include LoginHelpers

  context "signup" do
    before(:each) do
      visit root_path
      click_link "join"
    end

    it "should log in user upon successful signup" do
      user = FactoryGirl.build(:user)
      expect {
        fill_in 'user_first_name', with: user.first_name
        fill_in 'user_last_name',  with: user.last_name
        fill_in 'user_email',      with: user.email
        fill_in 'user_password',   with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation
        click_button "Create Account"
      }.to change(User, :count).by(1)

      page.should have_content "Admin Portal"
    end

    it "should display errors on unsuccessful signup" do
      click_button "Create Account"

      page.should have_content "Password must have at least 6 characters"
    end
  end

  context "login" do
    before(:each) do
      visit root_path
      click_link "log in"
    end

    it "should log in a user with proper credentials" do
      user = FactoryGirl.create(:user)

      fill_in 'email',    with: user.email
      fill_in 'password', with: user.password
      click_button "Sign In"

      page.should have_content 'Admin Portal'
    end

    it "displays errors on unsuccessful login" do
      click_button "Sign In"

      page.should have_content "Unsuccessful login. Please try again."
    end
  end

  context "footer while logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      user_login(@user)
    end

    it "should have a logout link" do
      page.should have_link "Sign Out"
    end

    it "should have the user's name" do
      page.should have_link @user.full_name
    end

    it "should not have the login or join link" do
      page.should_not have_link "log in"
      page.should_not have_link "join"
    end
  end

  context "log out" do
    it "should not display the logout link" do
      user = FactoryGirl.create(:user)
      user_login(user)
      click_link "Sign Out"

      page.should have_content 'You successfully logged out!'
      page.should_not have_content user.first_name
    end
  end

  context "while logged out" do
    it "should not be able to access any other page" do
      event = FactoryGirl.create(:event)

      visit event_path(event.url)
      page.should have_content 'You must be logged in to see this page'
      page.should_not have_content event.title
    end
  end
end
