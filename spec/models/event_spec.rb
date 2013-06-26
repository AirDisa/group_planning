require 'spec_helper'

describe Event do

  context 'creation' do

    it { should be_instance_of(Event) }

    it { should ensure_length_of(:title).is_at_least(4).
                with_message(/must have at least 4 letters/)}

    it { should allow_value("event description").for(:description) }

    it { should ensure_length_of(:emails).is_at_least(1).
                with_message(/must include at least one invitee/)}

    it { should belong_to(:creator).class_name(User) }
    it { should validate_presence_of(:creator_id) }

    it { should validate_presence_of(:commit_date) }
    it { should allow_value("Wed, 1 Jan 2020").for(:commit_date) }
    it { should_not allow_value("Sat, 1 Jan 2000").for(:commit_date) }

    it { should allow_value("/assets/images/test.png").for(:image) }

    it { should allow_value("event-slug").for(:url) }

  end

  context 'public methods' do

    before(:each) do
      @user   = FactoryGirl.create(:user)
      @event  = FactoryGirl.create(:event)
      @event_one = FactoryGirl.build(:event)
      @event_one.update_attribute("commit_date", "Fri, 2 Jan 2009")
      @invitee_one = Invitee.create(:user_id => @user.id, :event_id => @event.id, :status=>"Pending")
      @invitee_two = Invitee.create(:user_id => @user.id, :event_id => @event.id, :status=>"Yes")
      @invitee_three = Invitee.create(:user_id => @user.id, :event_id => @event.id, :status=>"No")
    end

    it 'can return a list of waffling invitees' do
      @event.waffling.should eq [@invitee_one]
    end

    it 'can return a list of going invitees' do
      @event.going.should eq [@invitee_two]
    end

    it 'can return a list of not_going invitees' do
      @event.not_going.should eq [@invitee_three]
    end

    it 'can tell if an event has closed' do
      @event.closed?.should eq false
      @event_one.closed?.should eq true
    end

    it 'can closeout an expired event' do
      @event_one.settle_event
      @event_one.settled.should eq true
    end
  end

end
