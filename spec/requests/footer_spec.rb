require 'spec_helper'

describe "Footer" do

  context "with no one logged in" do

    it "should not appear" do
      visit root_path
      page.should_not have_css('footer')
    end

  end

  context "with a user signed in" do
    include LoginHelpers

    before do
      @user   = FactoryGirl.create(:user)
      user_login(@user)
      visit root_path
    end

    it "should display on the page" do
      page.should have_css('footer')
    end

    it "should display the user's full name" do
      page.should have_content(@user.full_name)
    end

    it "should display their full name as a link" do
      page.should have_link(@user.full_name)
    end

    it "should link to their profile page from their full name" do
      click_link(@user.full_name)
      page.should have_content('your groupact profile:')
    end

    it "should have a Your Portal link" do
      page.should have_link('Your Portal')
    end

    it "should link to their portal page" do
      click_link('Your Portal')
      page.should have_content('your groupact portal: '+ @user.full_name)
    end

    it "should have a Sign Out link" do
      page.should have_link('Sign Out')
    end

    it "should sign out the user with the Sign Out link" do
      click_link('Sign Out')
      page.should_not have_css('footer')
    end

  end

end