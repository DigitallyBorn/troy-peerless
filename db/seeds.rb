# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..44).to_a.each do |n|
  ParkingSpot.find_or_create_by(number: n)
end

(1..35).to_a.each do |n|
  Unit.find_or_create_by(number: n) do |unit|
    unit.floor = 1 if (1..11).include? n
    unit.floor = 2 if (12..19).include? n
    unit.floor = 3 if n > 19
  end
end

unless Announcement.any?
  Announcement.create!(
    title: 'Site launch',
    body: 'Horray! A new site!',
    publish_date: DateTime.now,
    user: User.first)
end
