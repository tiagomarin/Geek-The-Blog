require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  user = if User.all.nil? || User.all == []
           [User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.'),
            post = Post.create(author: user, title: 'Hello', text: 'This is my first post')]
         else
           User.first
         end

  post = if user.posts.nil? || user.posts == []
           Post.create(author: user, title: 'Hello', text: 'This is my first post')
         else
           user.posts[0]
         end

  describe 'GET /index' do
    before(:example) { get "/users/#{user.id}/posts" }

    it 'returns a 200 (success)' do
      expect(response).to have_http_status(:ok) # same as => expect(response.status).to eq(200)
    end

    it 'assigns all posts to @posts' do
      expect(assigns(:posts)).to eq(user.posts.all)
    end

    it 'renders correct template' do
      expect(response).to render_template('posts/index') # or render_template(:index)
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('posts/show')
    end

    it 'renders post title correctly' do
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET /show' do
    before(:example) { get "/users/#{user.id}/posts/#{post.id}" }

    it 'returns a 200' do
      expect(response).to have_http_status(:ok) # same as => expect(response.status).to eq(200)
    end

    it 'renders the template for a single post' do
      expect(response).to render_template(:show) # or render_template('users/show')
    end

    it 'renders post title correctly' do
      expect(response.body).to include(post.text)
    end
  end
end
