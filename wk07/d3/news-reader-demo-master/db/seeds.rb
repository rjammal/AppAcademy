# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#

urls = [
  'http://feeds.wired.com/wired/index',
  'http://www.npr.org/rss/rss.php?id=1001', 
  "http://feeds.slate.com/slate", 
  "http://lorem-rss.herokuapp.com/feed?unit=second&interval=10"
]

urls.each do |url|
  Feed.find_or_create_by_url url
end
