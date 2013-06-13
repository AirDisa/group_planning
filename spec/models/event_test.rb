require 'spec_helper'

describe 'Event' do

  context 'create' do

    it 'should create a new event' do
      expect { FactoryGirl.create(:event) }.to change(Event, :count).by(1)
    end

    it 'should require a title' do
      FactoryGirl.build(:event, :title => '').should_not be_valid
    end

    it 'should require a title with at least 4 characters' do
      FactoryGirl.build(:event, :title => 'Abc').should_not be_valid
    end

    it 'should accept an optional description' do
      FactoryGirl.build(:event, :description => 'This is a test').should be_valid
    end

    it 'should require a creator id' do
      FactoryGirl.build(:event, :creator_id => '').should_not be_valid
    end

    it 'should require a commit date' do
      FactoryGirl.build(:event, :commit_date => '').should_not be_valid
    end

    it 'should require a commit date in the future' do
      FactoryGirl.build(:event, :commit_date => DateTime.new(2000,1,1)).should_not be_valid
    end

    it 'should accept an optional image path' do
      FactoryGirl.build(:event, :image => 'assets/images/test.png').should be_valid
    end

  end
end
