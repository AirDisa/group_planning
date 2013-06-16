require 'spec_helper'

describe Invitee do

  it { should be_instance_of(Invitee) }
  it { should belong_to(:user) }
  it { should belong_to(:event) }
  it { should have_many(:conditions) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:event) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:responded) }

end
