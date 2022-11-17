require 'faker'
# require 'unsplash'
User.create(name: 'Admin', email: 'tiago@gmail.com', password: '654321', role: 'admin')
case Rails.env
when "development"
  users = []
  posts = []
  
  10.times do
    users.push(User.create do |user|
      user.name = Faker::FunnyName.name_with_initial
      user.photo = Faker::Avatar.image
      user.bio = Faker::Lorem.paragraph
      user.email = Faker::Internet.email
      user.password = Faker::Internet.password
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
# -----------------------------------------------------------
# when "test"
#   users = []
#   user_names = %w(Ana John Karl Peter Joseph)
#   user_photos =  %w(profile-pic.com/ana profile-pic.com/john, profile-pic.com/karl, profile-pic.com/peter, profile-pic.com/joseph)
#   user_bios = ["This is Ana's bio", "This is John's bio", "This is Karl's bio", "This is Peter's bio", "This is Joseph's bio"]
#   user_emails = %w(ana@gmail.com john@gmail.com karl@gmail.com peter@gmail.com joseph@gmail.com)
#   user_passwords = %w(ana1234 john1234 karl1234 peter1234 joseph1234)
  
#   i = 0
#   10.times do
#     users.push(User.create do |user|
#       user.name = user_names[i]
#       user.photo = user_photos[i]
#       user.bio = user_bios[i]
#       user.email = user_emails[i]
#       user.password = user_passwords[i]
#     end
#     )
#     i += 1
#   end
  
#   posts = []
#   users.each do |user|
#     i = 0
#     7.times do
#       posts.push(Post.create do |post|
#         post.author_id = user.id
#         post.title = "Title of #{user.name}'s post nº#{i}"
#         post.text = "Text of #{user.name}'s post nº#{i} - #{Faker::Lorem.paragraph_by_chars(number: 280)}"
#       end
#       )
#       i += 1
#     end
#   end
  
#   users.reverse_each do |user|
#     30.times do
#       post = posts[rand(70)]
#       Comment.create do |comment|
#         comment.post_id = post.id
#         comment.author_id = user.id
#         comment.text = "Text of #{user.name}'s comment - #{Faker::Lorem.paragraph_by_chars(number: 280)}"
#       end
#     end
#   end
  
#   users.reverse_each do |user|
#     36.times do
#       post = posts[rand(69)]
#       Like.create do |like|
#         like.post_id = post.id
#         like.author_id = user.id
#       end
#     end
#   end
end
