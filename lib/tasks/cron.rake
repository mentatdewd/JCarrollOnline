desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour % 4 == 0 # run every four hours
    puts "Updating feed..."
    RssfeedEntry.update_from_feed("http://m.mariners.mlb.com/partnerxml/gen/news/rss/sea.xml")
    puts "done."
  end

  if Time.now.hour == 0 # run at midnight
    User.send_reminders
  end
end