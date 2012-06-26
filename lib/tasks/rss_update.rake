task  :rss_update => :environment do
   puts "Updating feed..."
    RssfeedEntry.update_from_feed("http://www.extremetech.com/feed")
    puts "done."

  end