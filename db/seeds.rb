# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  name  = Faker::Company.name
  description = Faker::Company.catch_phrase
  logo = Faker::Company.logo
  Organization.create!(name: name, description: description, logo: logo)
end