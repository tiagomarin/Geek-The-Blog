require 'faker'

users = []
posts = []

10.times do
  users.push(User.create do |user|
    user.name = Faker::Name.name
    user.photo = 'https://picsum.photos/200'
    user.bio = Faker::Lorem.paragraph
  end
  )
end

users.each do |user|
  3.times do
    posts.push(Post.create do |post|
      post.author_id = user.id
      post.title = 'Post Title'
      post.text = Faker::Lorem.paragraph
    end
    )
  end
end

users.reverse_each do |user|
  10.times do
    post = posts[rand(30)]
    Comment.create do |comment|
      comment.post_id = post.id
      comment.author_id = user.id
      comment.text = Faker::Lorem.paragraph
    end
  end
end

users.reverse_each do |user|
  6.times do
    post = posts[rand(30)]
    Like.create do |like|
      like.post_id = post.id
      like.author_id = user.id
    end
  end
end