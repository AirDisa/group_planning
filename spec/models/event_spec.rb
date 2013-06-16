require 'spec_helper'

describe Event do

  it { should be_instance_of(Event) }

  it { should ensure_length_of(:title).is_at_least(4).
              with_message(/must have at least 4 letters/)}
  
  it { should allow_value("event description").for(:description) }

  it { should ensure_length_of(:emails).is_at_least(6).
              with_message(/must include at least one invitee/)}

  it { should belong_to(:creator).class_name(User) }
  it { should validate_presence_of(:creator_id) }

  it { should validate_presence_of(:commit_date) }
  it { should allow_value(DateTime.new(2020,1,1)).for(:commit_date) }
  it { should_not allow_value(DateTime.new(2000,1,1)).for(:commit_date) }

  it { should allow_value("/assets/images/test.png").for(:image) }

  it { should allow_value("event-slug").for(:url) }
end
