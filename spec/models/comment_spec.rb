require 'spec_helper'

describe Comment do

  it { should be_instance_of(Comment) }

  it { should belong_to(:user).class_name(User) }

  it { should allow_value("Test Comment").for(:comment) }

  it "should return a time" do
    comment = Comment.create(:comment => "test", :user_id => 1)
    comment.time.should_not eq nil
  end

end
