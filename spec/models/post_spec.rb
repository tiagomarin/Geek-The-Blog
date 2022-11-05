require 'rails_helper'
require 'faker'

RSpec.describe Post, type: :model do
  # VALID user
  user = User.create(name: 'Jonh', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  # VALID post
  post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')

  context 'is created with proper key and values, passes all validations and it' do
    it 'should have a key "title" = Hello' do
      expect(post.title).to eql('Hello')
    end

    it 'should have a key "text" = This is my first post' do
      expect(post.text).to eql('This is my first post')
    end

    it 'should belong to a user with "name" = Jonh' do
      expect(post.author.name).to eql('Jonh')
    end

    it 'should have a key "comments_counter" greater or = 0' do
      expect(post.comments_counter).to be >= 0
    end

    it 'should have a key "likes_counter" greater or = 0' do
      expect(post.likes_counter).to be >= 0
    end
  end

  context 'validations should be working and' do
    it 'should have a relationship => posts belongs to an user' do # should have a valid author_id
      expect(post.author_id).to be_a(Integer)
      post.author_id = -1
      expect(post).to_not be_valid
      post.author_id = 'as12'
      expect(post).to_not be_valid
      post.author_id = nil
      expect(post).to_not be_valid
    end

    it 'title should be present' do
      post.author_id = user.id # reset to correct value
      expect(post).to be_valid
      post.title = nil
      expect(post).to_not be_valid
    end

    it '"title" should not be longer than 250 characters' do
      post.title = Faker::Lorem.paragraph_by_chars(number: 256)
      expect(post).to_not be_valid
    end

    it 'comments_counter should return a number' do
      expect(post.comments_counter).to be_a_kind_of(Integer)
    end

    it 'likes_counter should return a number' do
      expect(post.likes_counter).to be_a_kind_of(Integer)
    end
  end
end
