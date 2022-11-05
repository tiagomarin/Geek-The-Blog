require 'rails_helper'

RSpec.describe Like, type: :model do
  user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  post = Post.create(author_id: user1, title: 'Hello', text: 'This is my first post')

  like = Like.create(post_id: post.id, author_id: user2.id)

  context 'validations should be working and' do
    it 'should have a relationship => like belongs to an user' do # should have a valid post_id
      expect(like.author.name).to eql('Lilly')
      expect(like.author_id).to be_a(Integer)
      like.author_id = -1
      expect(like).to_not be_valid
      like.author_id = 'as12'
      expect(like).to_not be_valid
      like.author_id = nil
      expect(like).to_not be_valid
    end
  end
end
