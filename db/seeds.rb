require 'faker'

users = []
posts = []

10.times do
  users.push(User.create do |user|
    user.name = Faker::FunnyName.name_with_initial
    user.photo = Faker::LoremFlickr.colorized_image
    user.bio = Faker::Lorem.paragraph
  end
  )
end

users.each do |user|
  7.times do
    posts.push(Post.create do |post|
      post.author_id = user.id
      post.title = Faker::Lorem.sentence(word_count: 3)
      post.text = Faker::Lorem.paragraph_by_chars(number: 180)
    end
    )
  end
end

users.reverse_each do |user|
  20.times do
    post = posts[rand(30)]
    Comment.create do |comment|
      comment.post_id = post.id
      comment.author_id = user.id
      comment.text = Faker::Lorem.paragraph_by_chars(number: 80)
    end
  end
end

users.reverse_each do |user|
  36.times do
    post = posts[rand(30)]
    Like.create do |like|
      like.post_id = post.id
      like.author_id = user.id
    end
  end
end