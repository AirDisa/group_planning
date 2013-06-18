desc "Tasks to be run by the Heroku scheduler"
task :closeout_all_expired_events => :environment do
  puts "Closing out expired events..."
  Event.closeout_all_expired
  puts "...has now been completed."
end
