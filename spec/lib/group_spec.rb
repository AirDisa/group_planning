require 'spec_helper'

describe Group do
  let(:going)     { FactoryGirl.build(:going)     }
  let(:not_going) { FactoryGirl.build(:not_going) }

  context "should keep" do

    it "an invitee whose status is 'Yes'" do
      invitees = [going]
      Group.new(invitees).solve.should eq [going]
    end

    it "an invitee whose required person is going" do
      invitees = [going, invitee_pending_invitee(going)]
      Group.new(invitees).solve.should eq invitees
    end

    it "an invitee whose required count is satisfied" do
      invitees = [going, going, invitee_pending_count(3)]
      Group.new(invitees).solve.should eq invitees
    end

    it "invitees with nested count dependencies that pass" do
      invitees = [going, invitee_pending_count(3), invitee_pending_count(2)]
      Group.new(invitees).solve.should == invitees
    end

    it "invitees with nested invitee dependencies that pass" do
      maybe_going = invitee_pending_invitee(going)
      invitees = [going, maybe_going, invitee_pending_invitee(maybe_going)]
      Group.new(invitees).solve.should eq invitees
    end

  end

  context "should remove" do

    it "an invitee whose status is 'No'" do
      invitees = [not_going]
      Group.new(invitees).solve.should be_empty
    end
  
    it "an invitee whose required person isn't going" do
      invitees = [not_going, invitee_pending_invitee(not_going)]
      Group.new(invitees).solve.should be_empty
    end

    it "invitees with nested dependencies that fail" do
      maybe_going = invitee_pending_invitee(not_going)
      invitees = [not_going, maybe_going, invitee_pending_invitee(maybe_going)]
      Group.new(invitees).solve.should be_empty
    end

    it "an invitee whose required count isn't satisfied" do
      invitees = [going, invitee_pending_count(3)]
      Group.new(invitees).solve.should eq [going]
    end

    it "invitees with nested count dependencies that fail" do
      invitees = [not_going, invitee_pending_count(3), invitee_pending_count(2)]
      Group.new(invitees).solve.should be_empty
    end

  end

  context "should work" do

    it "when handling multiple dependencies for a single invitee" do
      going_1     = FactoryGirl.build(:going)
      going_2     = FactoryGirl.build(:going)
      complicated = invitee_pending_both(4, [going_1, going_2])

      invitees = [not_going, complicated, going_1, going_2]

      Group.new(invitees).solve.should_not include(complicated)
      Group.new(invitees).solve.length.should eq 2
    end

    it "when given a complex case" do
      complicated_1 = invitee_pending_both(5, [going])
      complicated_2 = invitee_pending_count(3)
      complicated_3 = invitee_pending_both(3, [complicated_2, going])

      invitees = [not_going, going, complicated_1, complicated_2, complicated_3]

      Group.new(invitees).solve.should_not include(complicated_1)
      Group.new(invitees).solve.should_not include(not_going)
      Group.new(invitees).solve.length.should eq 3
    end

  end

end

def invitee_pending_invitee(pending_invitee)
  invitee = FactoryGirl.build(:pending)
  invitee.conditions = [Condition.new(:value => pending_invitee.user_id, :method => "specific_person")]
  invitee
end

def invitee_pending_count(count)
  invitee = FactoryGirl.build(:pending)
  invitee.conditions = [Condition.new(:value => count, :method => "required_count")]
  invitee
end

def invitee_pending_both(count = 1, pending_invitees = [])
  invitee = FactoryGirl.build(:pending)
  invitee.conditions = [Condition.new(:value => count, :method => "required_count" )]
  pending_invitees.each do |i|
    invitee.conditions << Condition.new(:value => i.user_id, :method => "specific_person")
  end

  invitee
end
