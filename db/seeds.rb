users = []

10.times do
  users.push(User.create(Faker::Name.name, photo: 'https://picsum.photos/200', Faker::Lorem.bio 'Teacher from Mexico.'))
end

posts = []
users.each do |user|
  3.times do
    posts.push(Post.create(author: user, title: 'Post Title', Faker::Lorem.text))
  end
end

users.reverse_each do |user|
  3.times do
    Comment.create(post: posts[rand(30)], author: user, Faker::Lorem.text)  
  end
end
