# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  aa = User.create(email: 'april.arcus@gmail.com', password: 'p@$$w0rd')
  rj = User.create(email: 'rjammal@gmail.com', password: 'password')
  cj = User.create(email: 'cjavilla@gmail.com', password: 'password')
  
  c1 = Circle.create(name: 'The Hellfire Club', owner: aa, members: [rj, cj])
  c2 = Circle.create(name: 'Torus', owner: rj, members: [aa, cj])
  
  p1 = Post.create(
      body: 'Hello World', 
      author: aa, 
      links: [Link.new(url: 'http://www.google.com')], 
      circles: [c1]
  )
end