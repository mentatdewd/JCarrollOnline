task :rss_update => :environment do
  puts "Updating feed..."
  RssfeedEntry.update_from_feed("http://m.mariners.mlb.com/partnerxml/gen/news/rss/sea.xml")
  puts "done."
end