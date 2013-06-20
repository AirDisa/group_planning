require 'spec_helper'

describe Event do

  context 'creation' do

    it { should be_instance_of(Event) }

    it { should ensure_length_of(:title).is_at_least(4).
                with_message(/must have at least 4 letters/)}

    it { should allow_value("event description").for(:description) }

    it { should ensure_length_of(:emails).is_at_least(6).
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

    it 'can return a list of waffling invitees'

    it 'can return a list of going invitees'

    it 'can return a list of not_going invitees'

    it 'can tell if an event has closed'

    it 'can closeout an expired event'

  end

end
