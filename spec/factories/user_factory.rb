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

  factory :user2, :class => User do
    id '2'
    first_name 'Sally'
    last_name 'Jane'
    url 'sally-jane'
    email 'sjane@test.com'
    password 'Secure1'
    password_confirmation 'Secure1'
    web 'www.test.com'
    profile 'Cred fashion axe gentrify food truck'
  end
end
