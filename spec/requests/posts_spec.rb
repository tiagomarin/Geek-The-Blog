require 'rails_helper'
require 'faker'

RSpec.describe 'Posts', type: :request do
  before :each do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        email: 'tom@gmail.com', password: 'tom1234')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
  end

  context 'GET /index' do
    before(:example) { get "/users/#{@user.id}/posts" }

    it 'returns a 200 (success)' do
      expect(response).to have_http_status(:ok) # same as => expect(response.status).to eq(200)
    end

    it 'assigns all posts to @posts' do
      expect(assigns(:posts)).to eq(@user.posts.all)
    end

    it 'renders correct template' do
      expect(response).to render_template('posts/index') # or render_template(:index)
    end

    it 'does not render a different template' do
      expect(response).to_not render_template('posts/show')
    end

    it 'renders post title correctly' do
      expect(response.body).to include(@post.title)
    end
  end

  context 'GET /show' do
    before(:example) { get "/users/#{@user.id}/posts/#{@post.id}" }

    it 'returns a 200' do
      expect(response).to have_http_status(:ok) # same as => expect(response.status).to eq(200)
    end

    it 'renders the template for a single post' do
      expect(response).to render_template(:show) # or render_template('users/show')
    end

    it 'renders post title correctly' do
      expect(response.body).to include(@post.text)
    end
  end

  context 'POST /new' do
    include RSpecHtmlMatchers
    before(:example) { get "/users/#{@user.id}/posts/new" }
    it 'renders a form to add a post' do
      expect(response).to have_http_status(:ok)
      expect(response.body).to have_tag :form, action: "/users/#{@user.id}/posts", method: 'post'
      expect(response.body).to have_tag :input, type: 'text', name: 'post[title]', id: 'post_title'
      expect(response.body).to have_tag :input, type: 'text', name: 'post[text]', id: 'post_text'
      expect(response.body).to have_tag :input, type: 'submit', name: 'commit'
    end
  end

  context 'POST #create' do
    valid_attributes = {
      author: @user,
      title: Faker::Lorem.sentence(word_count: 3),
      text: Faker::Lorem.paragraph_by_chars(number: 180)
    }
    before :each do
      post user_posts_path(@user),
           params: { post: valid_attributes }
    end
    it 'creates a new post' do
      expect(response).to have_http_status(302)
    end
    it 'updates the counter' do
      expect { post user_posts_path(@user), params: { post: valid_attributes } }.to change(Post, :count).by(1)
    end
    it 'create a new post and redirects to url "user/1"' do
      expect(response).to redirect_to(user_path(@user))
      expect(response).to redirect_to(user_path(@user.id))
    end
  end
end
