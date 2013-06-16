FactoryGirl.define do
  factory :user do
    id '1'
    first_name 'John'
    last_name 'Doe'
    url 'john-doe'
    email 'johndoe@test.com'
    password 'Password1'
    password_confirmation 'Password1'
  end
end
