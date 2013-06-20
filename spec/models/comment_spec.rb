require 'spec_helper'

describe Comment do

  before do
    @comment = Comment.create(:comment => "test", :user_id => 1)
  end

  it { should be_instance_of(Comment) }

  it { should belong_to(:user).class_name(User) }

  it { should allow_value("Test Comment").for(:comment) }

  it "should return a time" do
    @comment.time.should_not eq nil
  end

end