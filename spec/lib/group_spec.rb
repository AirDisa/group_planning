require 'spec_helper'

describe Group do
  it "still needs a bunch of tests"
end



# User.destroy_all
# Event.destroy_all
# Condition.destroy_all

# u1 = User.create( first_name: "Mitch1",
#                   last_name:  "Lee1",
#                   email:      "mitch1@gmail.com",
#                   password:   "Password1",
#                   password_confirmation: "Password1")

# u2 = User.create( first_name: "Mitch2",
#                   last_name:  "Lee2",
#                   email:      "mitch2@gmail.com",
#                   password:   "Password1",
#                   password_confirmation: "Password1")

# u3 = User.create( first_name: "Mitch3",
#                   last_name:  "Lee3",
#                   email:      "mitch3@gmail.com",
#                   password:   "Password1",
#                   password_confirmation: "Password1")

# event = Event.create( title: "Test Concert",
#                       commit_date: Time.at(Time.now + rand(86400..604800)),
#                       creator_id: u1.id)

# i1 = Invitee.create(user_id: u1.id, event_id: event.id, status: "Pending")
# i2 = Invitee.create(user_id: u2.id, event_id: event.id, status: "Pending")
# i3 = Invitee.create(user_id: u3.id, event_id: event.id, status: "Pending")

# c1 = Condition.create(text: "Specific Person", method: "specific_person", value: u2.id, invitee_id: i1.id)
# c2 = Condition.create(text: "Person Count",    method: "required_count", value: 2, invitee_id: i2.id)
# c3 = Condition.create(text: "Person Count",    method: "required_count", value: 2, invitee_id: i3.id)

# p Group.new([i1, i2, i3]).solve.length