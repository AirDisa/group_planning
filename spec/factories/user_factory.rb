FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'johndoe@test.com'
    password 'Password1'
    password_confirmation 'Password1'
  end
end
