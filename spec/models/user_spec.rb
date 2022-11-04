require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(name: 'Ana', photo: 'https://photoUrl.com', bio: 'Teacher from Mexico.')

  context 'User is created with proper key and values, passes all validations and it ' do
    it 'should have a key name = Ana' do
      expect(user.name).to match('Ana')
    end
    it 'should have a key photo = https://photoUrl.com' do
      expect(user.photo).to match('https://photoUrl.com')
    end
    it 'should have a key bio = Teacher from Mexico' do
      expect(user.bio).to match('Teacher from Mexico')
    end
    it 'should have a key posts_counter = 0' do
      expect(user.posts_counter).to match(0)
    end
  end

  context 'Validations should be working and' do
    it '"name" should be present' do
      expect(user).to be_valid
      user.name = nil
      expect(user).to_not be_valid
    end
    it '"name" should not be shorter than 3 characters' do
      user.name = 'aa'
      expect(user).to_not be_valid
    end
    it '"name" should not be longer than 25 characters' do
      user.name = 'Name is longer than 25 characters'
      expect(user).to_not be_valid
    end

    it '"posts_counter" should return a number' do
      expect(user.posts_counter).to be_a_kind_of(Integer)
    end
  end
end
