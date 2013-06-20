require 'spec_helper'

describe "Profile updating" do
  include LoginHelpers

  before do
    @user  = FactoryGirl.create(:user, :profile_pic => "image.jpg")
    user_login(@user)
    visit profile_path(@user.url)
  end

  it "should be linked to from the Profile page" do
    click_link ('Edit')
    page.should have_content('edit your info')
  end

  it "should be able to update the first name" do
    click_link ('Edit')
    fill_in 'user_first_name', with: "Jimbo"
    click_button 'Update Profile'
    page.should have_content("Jimbo")
  end

  it "should be able to update the last name" do
    click_link ('Edit')
    fill_in 'user_last_name', with: "McCartney"
    click_button 'Update Profile'
    page.should have_content("McCartney")
  end

  it "should be able to add a profile" do
    click_link ('Edit')
    fill_in 'user_profile', with: "Test Profile"
    click_button 'Update Profile'
    page.should have_content("Test Profile")
  end

  it "should be able to add a website link" do
    click_link ('Edit')
    fill_in 'user_web', with: "www.test.com"
    click_button 'Update Profile'
    page.should have_content("www.test.com")
  end

end