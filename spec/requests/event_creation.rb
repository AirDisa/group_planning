require 'spec_helper'

describe 'Event Creation' do 

  context "filling in event fields", :js => true do
    include LoginHelpers

    before(:each) do
      @user = FactoryGirl.create(:user)
      user_login(@user)
      visit admin_path(@user.url)
    end

    it "requires event title" do
      fill_in "event_description", with: "Event Description"
      select "Sporting", from: "event_image"
      find("#event_commit_date").click
      find(".picker__nav--next").click
      page.all(".picker__day.picker__day--infocus")[0].click
      click_on("next")
      page.should have_content("You Must Have an Event Title and Commit Date")
    end

    it "requires a commit date" do
      fill_in "event_title", with: "Event Title"
      fill_in "event_description", with: "Event Description"
      select "Sporting", from: "event_image"
      click_on("next")
      page.should have_content("You Must Have an Event Title and Commit Date")
    end

    it "should have next button enabled when required fields are filled in" do
      fill_in "event_title", with: "Event Title"
      fill_in "event_description", with: "Event Description"
      select "Sporting", from: "event_image"
      find("#event_commit_date").click
      find(".picker__nav--next").click
      page.all(".picker__day.picker__day--infocus")[0].click
      click_on("next")
      page.should have_content("invite your friends:")
    end
  end

  context "filling in email fields", :js=>true do
    include LoginHelpers

    before do
      @user = FactoryGirl.create(:user)
      user_login(@user)
      visit admin_path(@user.url)

      fill_in "event_title", with: "Event Title"
      fill_in "event_description", with: "Event Description"
      select "Sporting", from: "event_image"
      find("#event_commit_date").click
      find(".picker__nav--next").click
      page.all(".picker__day.picker__day--infocus")[0].click
      click_on "next"
    end

    it "should have input email fields visible" do
      page.should have_css('#emails', :visible => true)
    end

    it "should create event if one email is entered" do
      fill_in "event_emails_0", with: "yannick@gmail.com"
      click_button "Create Event"
      page.should have_content("Your new event was created successfully!")
    end

    it "should create event if multiple emails are entered" do
      fill_in "event_emails_0", with: "yannick@gmail.com"
      fill_in "event_emails_1", with: "yannick@gmail.com"
      click_button "Create Event"
      page.should have_content("Your new event was created successfully!")
    end

    it "should require at least one email to be entered" do
      click_button "Create Event"
      page.should have_content("An error occured while trying to make the event")
    end

  end
end


