require 'faker'

#Create Users
20.times do
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
  post = Post.create!(
    user:  users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )

  post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  post.update_rank
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

admin = User.new(
  name: 'Joe',
  email: 'jpalmieri@lumoslabs.com',
  password: 'a5551212',
  role: 'admin' 
)
admin.skip_confirmation!
admin.save

moderator = User.new(
  name: 'hobojoe',
  email: 'jpalmieri+123@lumoslabs.com',
  password: 'a5551212',
  role: 'moderator' 
)
moderator.skip_confirmation!
moderator.save

member = User.new(
  name: 'derpadoo',
  email: 'jpalmieri+111@lumoslabs.com',
  password: 'a5551212',
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"