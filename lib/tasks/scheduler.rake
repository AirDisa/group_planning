desc "Tasks to be run by the Heroku scheduler"
task :update_all_event_statuses => :environment do
  puts "Updating event statuses..."
  Event.update_all_statuses
  puts "...has now been completed."
end

task :closeout_all_expired_events => :environment do
  puts "Closing out expired events..."
  Event.closeout_all_expired
  puts "...has now been completed."
end
