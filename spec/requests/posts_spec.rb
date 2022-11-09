require 'rails_helper'
require 'faker'

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

  describe 'POST /new' do
    include RSpecHtmlMatchers
    before(:example) { get "/users/#{user.id}/posts/new" }
    it 'renders a form to add a post' do
      expect(response).to have_http_status(:ok)
      expect(response.body).to have_tag :form, action: "/users/#{user.id}/posts", method: 'post'
      expect(response.body).to have_tag :input, type: 'text', name: 'post[title]', id: 'post_title'
      expect(response.body).to have_tag :input, type: 'text', name: 'post[text]', id: 'post_text'
      expect(response.body).to have_tag :input, type: 'submit', name: 'commit'
    end
  end

  # when a post is succesfully created it redirects to user/user.id,
  # I want to test this, the following is not working yet

  # describe 'POST #create' do
  #   context 'with valid params' do
  #     it 'creates a new post' do
  #       expect { post user_post_path, params: { post: valid_attributes } }.to change(Post, :count).by(1)
  #       expect(response).to redirect_to user_posts_path(user)
  #     end
  #   end

  #   context 'with invalid params' do
  #     it 'does not create a new post' do
  #       expect { post posts_path, params: { post: invalid_attributes } }.not_to change(Post, :count)
  #       expect(response).to have_http_status 200
  #     end
  #   end
  # end
  # describe 'POST /create' do
  #   include RSpecHtmlMatchers
  # before(:example) do
  #   post "/users/#{user.id}/post",
  #        params: { author: user.id, title: Faker::Lorem.sentence(word_count: 3),
  #                  text: Faker::Lorem.paragraph_by_chars(number: 180) }
  # end

  #   it 'create a new post and redirects to url "user/1"' do
  #     expect(response).to have_http_status(:ok)
  #     expect(response).to redirect_to(user_path)
  #   end
  # end
end
