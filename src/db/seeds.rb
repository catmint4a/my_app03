# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
    name: "sample",
    user_name: "サンプルさん",
    email: "sample@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true
  )

guest_user = User.create(
    name: "guestuser",
    user_name: "ゲストさん",
    email: "guest@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true
  )

99.times do |n|
  name  = (Faker::Name.name).gsub(/ /, "").delete("/[\.']/")
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(name:  name,
                user_name: name.upcase,
                email: email,
                password:              password,
                password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

user2 = guest_user
following = users[3..50]
followers = users[4..40]
following.each { |followed| user2.follow(followed) }
followers.each { |follower| follower.follow(user2) }

microposts = Micropost.all
microposts_id = microposts[3..30]

microposts_id.each { |micropost|
  like = Like.new(
    user_id: user.id,
    micropost_id: micropost.id,
  )
  like.save
  like2 = Like.new(
      user_id: user2.id,
      micropost_id: micropost.id,
    )
    like2.save
}
