first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

first_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'This is my first post')

Comment.create(post_id: first_post.id, author_id: second_user.id, text: 'Hi Tom!')

Like.create(post_id: first_post.id, author_id: second_user.id)

# using Faker Gem to add fake data (not working yet)

# 10.times do
#   User.create do |user|
#     user.name = Faker::Name.name
#     user.photo = 'https://picsum.photos/200'
#     user.bio = Faker::Lorem.paragraph
#   end
# end

# users.each do |user|
#   3.times do
#     Post.create do |post|
#       post.author_id = user.id
#       post.title = 'Post Title'
#       post.text = Faker::Lorem.paragraph
#     end
#   end
# end

# users.reverse_each do |user|
#   3.times do
#     post = posts[rand(30)]
#     Comment.create do |comment|
#       comment.post_id = post.id
#       comment.author_id = user.id
#       comment.text = Faker::Lorem.paragraph
#     end
#   end
# end

# users.reverse_each do |user|
#   3.times do
#     post = posts[rand(30)]
#     Like.create do |like|
#       like.post_id = post.id
#       like.author_id = user.id
#     end
#   end
# end