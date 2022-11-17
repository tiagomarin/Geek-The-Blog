require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(name: 'Ana', photo: 'https://photoUrl.com', bio: 'Teacher from Mexico.',
                        email: 'ana@gmail.com', password: 'ana1234')
  end

  context 'User is created with proper key and values, passes all validations and it ' do
    it 'should have a key name = Ana' do
      expect(@user.name).to eql('Ana')
    end
    it 'should have a key photo = https://photoUrl.com' do
      expect(@user.photo).to eql('https://photoUrl.com')
    end
    it 'should have a key bio = Teacher from Mexico.' do
      expect(@user.bio).to eql('Teacher from Mexico.')
    end
    it 'should have a key posts_counter = 0' do
      expect(@user.posts_counter).to eql(0)
    end
  end

  context 'Validations should be working and' do
    it 'should have a key posts_counter greater or = 0' do
      expect(@user.posts_counter).to be >= 0
    end
    it '"name" should be present' do
      expect(@user).to be_valid
      @user.name = nil
      expect(@user).to_not be_valid
    end
    it '"name" should not be shorter than 3 characters' do
      @user.name = 'aa'
      expect(@user).to_not be_valid
    end
    it '"name" should not be longer than 25 characters' do
      @user.name = 'Name is longer than 25 characters'
      expect(@user).to_not be_valid
    end

    it '"posts_counter" should return a number' do
      expect(@user.posts_counter).to be_a_kind_of(Integer)
    end
  end
end
