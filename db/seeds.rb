require 'faker'

#Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

#Create Topics
20.times do
  Topic.create!(
    name: Faker::Lorem.sentence,
    description:  Faker::Lorem.paragraph,
    public: true
  )
end
topics=Topic.all

#Create Posts
500.times do
  Post.create!(
    user:  users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
end
posts=Post.all

#Create Comments
5000.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

User.first.update_attributes!(
  email: 'jpalmieri@gmail.com',
  password: 'password'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"