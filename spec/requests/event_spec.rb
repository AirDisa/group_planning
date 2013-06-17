require 'spec_helper'

describe "Event page" do
  include LoginHelpers

  before do
    @user  = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)
    @user2 = FactoryGirl.create(  :user,  :first_name => "Janie",
                                          :last_name => "Jones",
                                          :email => 'jjones@email.com',
                                          :id => 5)
    @invite1 = Invitee.create(:user_id => @user.id, :event_id => @event.id)
    @invite2 = Invitee.create(:user_id => @user2.id, :event_id => @event.id)
    user_login(@user)
    visit event_path(@event.url)
  end

  context "in the user column" do
    it "should display the creator's profile picture" do
      page.should have_css('img.profile_pic')
    end

    it "should display the creator's full name" do
      page.should have_content(@user.full_name)
    end

    it "should link to the creator's profile page" do
      first('h2 > a').click
      current_path.should eq profile_path(@user.url)
    end

    it "should display invited users full names" do
      page.should have_content(@user2.full_name)
    end

    it "should link to invited users' profile pages" do
      click_link("Janie Jones")
      current_path.should eq profile_path(@user2.url)
    end

    it "should display pending users" do
      user3 = FactoryGirl.create(  :user,  :first_name => "Jimmie",
                                            :last_name => "Jones",
                                            :email => 'jjones9@email.com',
                                            :id => 10)
      invite = Invitee.create(:user_id => user3.id, :event_id => @event.id, :status => "Pending")
      visit event_path(@event.url)
      page.should have_content(user3.full_name)
    end

    it "should display confirmed users" do
      user3 = FactoryGirl.create(  :user,  :first_name => "Jimmie",
                                            :last_name => "Jones",
                                            :email => 'jjones9@email.com',
                                            :id => 10)
      invite = Invitee.create(:user_id => user3.id, :event_id => @event.id, :status => "Yes")
      visit event_path(@event.url)
      page.should have_content(user3.full_name)
    end

    it "should display users who are not going" do
      user3 = FactoryGirl.create(  :user,  :first_name => "Jimmie",
                                            :last_name => "Jones",
                                            :email => 'jjones9@email.com',
                                            :id => 10)
      invite = Invitee.create(:user_id => user3.id, :event_id => @event.id, :status => "No")
      visit event_path(@event.url)
      page.should have_content(user3.full_name)
    end
  end

  context "in the event description" do
    it "should display an event photo" do
      page.should have_css('.event_page_image')
    end

    it "should display the event title" do
      page.should have_content(@event.title)
    end

    it "should display the event description" do
      page.should have_content(@event.description)
    end
  end

  context "in the comments section" do
    it "should have an input for a new comment" do
      page.should have_css('input#comment')
    end

    it "should display an entered comment" do
      fill_in 'comment',   with: "It's the final countdown"
      click_button "Comment"
      page.should have_content("It's the final countdown")
    end

    it "should display who entered the comment" do
      fill_in 'comment',   with: "It's the final countdown"
      click_button "Comment"
      page.should have_css(".comment_posted_at")
    end

    it "should display when the comment was entered" do
      fill_in 'comment',   with: "It's the final countdown"
      click_button "Comment"
      page.should have_content("- Posted")
    end
  end

end