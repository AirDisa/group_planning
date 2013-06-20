FactoryGirl.define do
  factory :event do
    title 'Test Event'
    commit_date "Wed, 1 Jan 2020"
    creator_id 1
    image  "events/default.jpg"
    emails 'test@test.com'
  end

   factory :event_one, :class => Event do
    title 'Test Event'
    commit_date "Fri, 2 Jan 2009"
    creator_id 1
    image  "events/default.jpg"
    emails 'test@test.com'
  end
end
