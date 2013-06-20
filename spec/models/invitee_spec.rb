require 'spec_helper'

describe Invitee do

  it { should be_instance_of(Invitee) }
  it { should belong_to(:user) }
  it { should belong_to(:event) }
  it { should have_many(:conditions) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:event) }

  context "methods" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event)
    end

    it "should be able to reset it's condition" do
      invitee = Invitee.create(:user_id => 1, :event_id => 1, :status => "Yes")
      invitee.reset_conditions
      invitee.status.should eq "Pending"
    end

    it "should be able to return events with a status of 'No'" do
      invitee = FactoryGirl.create(:not_going, :user_id => @user.id, :event_id => @event.id)
      Invitee.not_going(Event.all).should eq [@event]
    end

    it "should be able to return events with a status of 'Yes'" do
      invitee = FactoryGirl.create(:going, :user_id => @user.id, :event_id => @event.id)
      Invitee.going(Event.all).should eq [@event]
    end

    it "should be able to return events with a status of 'Pending'" do
      invitee = FactoryGirl.create(:pending, :user_id => @user.id, :event_id => @event.id)
      Invitee.pending(Event.all).should eq [@event]
    end

  end

end
