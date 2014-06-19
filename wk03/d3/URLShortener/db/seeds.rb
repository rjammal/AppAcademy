# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create!(email: "newemail11")
user2 = User.create!(email: "newemail22")
user3 = User.create!(email: "newemail33")

url1 = ShortenedURL.create_for_user_and_long_url!(user1, "gmail.com")
url2 = ShortenedURL.create_for_user_and_long_url!(user2, "gmail.com")
url3 = ShortenedURL.create_for_user_and_long_url!(user1, "joelonsoftware.com")
url4 = ShortenedURL.create_for_user_and_long_url!(user1, "ufc.com")
url5 = ShortenedURL.create_for_user_and_long_url!(user3, "gmail.com")
url6 = ShortenedURL.create_for_user_and_long_url!(user3, "joelonsoftware.com")

visit1 = Visit.record_visit!(user1, url1)
visit2 = Visit.record_visit!(user2, url2)
visit3 = Visit.record_visit!(user2, url4)
visit4 = Visit.record_visit!(user3, url5)
visit5 = Visit.record_visit!(user1, url3)
visit6 = Visit.record_visit!(user1, url1)
visit7 = Visit.record_visit!(user2, url2)
visit8 = Visit.record_visit!(user3, url3)

tag1 = TagTopic.create!(topic: "tech")
tag2 = TagTopic.create!(topic: "sports")
tag3 = TagTopic.create!(topic: "ufc")
tag4 = TagTopic.create!(topic: "how to")
tag5 = TagTopic.create!(topic: "humor")

tagging1 = Tagging.create_from_tag_and_url!(tag1, url1)
tagging2 = Tagging.create_from_tag_and_url!(tag1, url3)
tagging3 = Tagging.create_from_tag_and_url!(tag1, url5)
tagging4 = Tagging.create_from_tag_and_url!(tag2, url4)
tagging5 = Tagging.create_from_tag_and_url!(tag3, url4)
tagging6 = Tagging.create_from_tag_and_url!(tag4, url6)
tagging7 = Tagging.create_from_tag_and_url!(tag5, url2)
tagging8 = Tagging.create_from_tag_and_url!(tag5, url3)

