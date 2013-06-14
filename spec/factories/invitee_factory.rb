FactoryGirl.define do

  sequence :user_id do |n|
    n
  end

  factory :going, :class => Invitee do
    user_id
    event_id 1
    status "Yes"
  end

  factory :not_going, :class => Invitee do
    user_id
    event_id 1
    status "No"
  end

  factory :pending, :class => Invitee do
    user_id
    event_id 1
    status "Pending"
  end

end
