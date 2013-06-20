require 'spec_helper'

describe 'user condition entry', :js => true do
  include LoginHelpers

  before(:each) do
    @user   = FactoryGirl.create(:user)
    @event  = FactoryGirl.create(:event)
    @invitee = Invitee.create(:user_id => @user.id, :event_id => @event.id)
    user_login(@user)
    visit event_path(@event.url)
  end

  context 'when user has not responded' do
    it 'should display the available options' do
      find_button('Yes').should be_visible
      find_button('No').should be_visible
      find_button('yes_if').should be_visible
    end

    it 'should not display the confirmation messages' do
      page.all('#close_window', :visible => true).length.should eq 0
    end

    it 'should confirm when the user clicks yes' do
      click_button "Yes"
      sleep(1)
      page.all('#close_window', :visible => true).length.should eq 1
    end

    it 'should confirm when the user clicks no' do
      click_button "No"
      sleep(1)
      page.all('#close_window', :visible => true).length.should eq 1
    end

    it 'should allow for condition entry when the user clicks yes IF' do
      click_button "yes_if"
      sleep(1)
      page.all('.yes_if', :visible => true).length.should eq 1
    end
  end

  context 'when user is entering conditions' do
    before(:each) do
      click_button "yes_if"
      sleep(1)
    end

    it 'should display a prompt to enter conditions' do
      page.should have_content("I will attend this event IF")
    end

  end

  context 'when the user has already responded' do
    before do
      @invitee.update_attribute("responded", true)
      visit event_path(@event.url)
    end

    it 'should not display the available options' do
      page.has_button?('Yes').should eq false
      page.has_button?('No').should eq false
      page.has_button?('yes_if').should eq false
    end
  end

  context 'reset conditions' do

    it 'should not show reset conditions button when user has not made a choice' do
      page.should_not have_selector('#reset_button')
    end

    it 'should show reset condition when user has responded' do
      @invitee.update_attributes(:responded => true, :status => "Yes")
      visit event_path(@event.url)
      page.should have_selector('#reset_button')
    end
  end
end
