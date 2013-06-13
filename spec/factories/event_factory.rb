FactoryGirl.define do
  factory :event do
    title 'Test Event'
    commit_date DateTime.new(2020,1,1)
    creator_id 1
  end
end
