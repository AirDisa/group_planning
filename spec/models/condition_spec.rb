require 'spec_helper'

describe Condition do

  it { should be_instance_of(Condition) }
  it { should belong_to(:invitee) }

  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:method) }
  it { should validate_presence_of(:value) }

end
