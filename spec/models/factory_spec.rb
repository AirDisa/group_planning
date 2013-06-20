require 'spec_helper'

describe "Factory" do

  it 'should have a valid event factory' do
    FactoryGirl.create(:event).should be_valid
  end

  it 'should have a valid user factory' do
    FactoryGirl.create(:user).should be_valid
  end

end
