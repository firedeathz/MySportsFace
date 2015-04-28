# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create!(name:  "Marcos Germano", email: "mikazzz_pro@hotmail.com", password: "HEARTless0", password_confirmation: "HEARTless0")

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

users = User.all
user  = users.first
following = users[2..40]
followers = users[3..20]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

50.times do |n|
  name  = Faker::Company.name
  description = Faker::Company.catch_phrase
  logo = Faker::Company.logo
  Organization.create!(name: name, description: description, logo: logo, articles_attributes: [ { title: "Example Title", description: "Article description", author: "Marcos", comments_attributes: [ { author: "Marcos Germano", user_id: 1, article_id: n+1, body: "Test" } ] } ])
end