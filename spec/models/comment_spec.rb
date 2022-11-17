require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         email: 'tom@gmail.com', password: 'tom1234')
    @user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.',
                         email: 'lilly@gmail.com', password: 'lilly1234')
    @post = Post.create(author_id: @user1, title: 'Hello', text: 'This is my first post')

    @comment = Comment.create(post_id: @post.id, author_id: @user2.id, text: 'Hi Tom!')
  end

  context 'validations should be working and' do
    it 'should have a relationship => comment belongs to an user' do # should have a valid post_id
      expect(@comment.author.name).to eql('Lilly')
      expect(@comment.author_id).to be_a(Integer)
      @comment.author_id = -1
      expect(@comment).to_not be_valid
      @comment.author_id = 'as12'
      expect(@comment).to_not be_valid
      @comment.author_id = nil
      expect(@comment).to_not be_valid
    end
  end
end
