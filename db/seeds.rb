# Make Users

first_name = ["Yannick", "Mitch", "Andrew", "Jack", "Erik", "Danny", "Lora", "Earl", "Garrett", "Henry"]
last_name = ["Smith", "Guy", "Brown"]

first_name.each do |first_name|
  User.create(first_name: first_name,
              last_name:             last_name.sample,
              email:                 first_name.downcase+"@gmail.com",
              password:              "Password1",
              password_confirmation: "Password1")
end

users = User.all

# Make Events

50.times do
  Event.create(title: Faker::Company.name,
               description: Faker::Lorem.paragraph(sentence_count = 3),
               commit_date: Time.at(Time.now + rand(86400..604800)),
               creator_id: users.sample.id)
end

events = Event.all

# User.all.each do |user|
#   user.events.each do |event|
#     Invitee.create(user_id: users.sample(rand(2..10)))


