# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do 

  User.create(email: 'test1@example.com', password: 'password')
  User.create(email: 'test2@example.com', password: 'password')
  User.create(email: 'test3@example.com', password: 'password')

  Band.create(name: "Chili Peppers")
  Band.create(name: "Daft Punk")
  Band.create(name: "My band")

  Album.create(name: "Californication", recording_type: "live", band_id: 1)
  Album.create(name: "By the Way", recording_type: "studio", band_id: 1)
  Album.create(name: "Random Access Memories", recording_type: "studio", band_id: 2)
  Album.create(name: "Interstella 555", recording_type: "live", band_id: 2)
  Album.create(name: "Random album", recording_type: "studio", band_id: 3)

  Track.create(name: "Californication", track_type: "regular", album_id: 1, lyrics: "some lyrics")
  Track.create(name: "Scar Tissue", track_type: "regular", album_id: 1, lyrics: "some lyrics")
  Track.create(name: "Otherside", track_type: "regular", album_id: 1, lyrics: "some lyrics")
  Track.create(name: "By the Way", track_type: "regular", album_id: 2, lyrics: "some lyrics")
  Track.create(name: "On Mercury", track_type: "regular", album_id: 2, lyrics: "some lyrics")
  Track.create(name: "Dosed", track_type: "regular", album_id: 2, lyrics: "some lyrics")
  Track.create(name: "Technologic", track_type: "regular", album_id: 3, lyrics: "some lyrics")
  Track.create(name: "Harder Better Faster Stronger", track_type: "bonus", album_id: 3, lyrics: "some lyrics")
  Track.create(name: "Around the World", track_type: "regular", album_id: 4, lyrics: "some lyrics")
  Track.create(name: "Random Song 1", track_type: "regular", album_id: 5, lyrics: "some lyrics")
  Track.create(name: "Random Song 2", track_type: "regular", album_id: 5, lyrics: "some lyrics")


end