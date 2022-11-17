RSpec.describe 'posts/index.html.erb', type: :system do
  before do
    driven_by(:rack_test)
  end

  before :each do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        email: 'tom@gmail.com', password: 'tom1234')
    @user2 = User.create(name: 'Ana', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Argentina.',
                         email: 'ana@gmail.com', password: 'ana1234')
    @post_counter = 0
    @post = Post.create(author: @user, title: 'Hello Tom', text: 'This is my first post')
    @post_counter += 1
    @post2 = Post.create(author: @user, title: 'Hi there', text: 'This is my sencond post')
    @post_counter += 1
    @post3 = Post.create(author: @user, title: 'Bye', text: 'This is my third post')
    @post_counter += 1
    Comment.create(post_id: @post.id, author_id: @user2.id, text: 'I really like your idea.')
    Like.create(post_id: @post.id, author_id: @user2.id)
    visit user_posts_path(@user)
  end

  it 'renders user images' do
    expect(page).to have_css('img', count: 1) # image
  end

  it 'loads user name correctly into the page' do
    expect(page).to have_content('Tom')
    expect(page).to have_css('h3', text: 'Tom')
  end

  it 'renders nº of posts user has written' do
    expect(page).to have_content("nº of posts: #{@user.posts.length}")
  end

  it 'renders post title correctly' do
    expect(page).to have_content('Hi there')
    expect(page).to have_content('Hello Tom')
  end

  it 'renders post body correctly' do
    expect(page).to have_content('This is my third post')
  end

  it 'renders available posts' do
    expect(page).to have_css("#post-#{@post.id}")
    expect(page).to have_css("#post-#{@post2.id}")
    expect(page).to have_css("#post-#{@post3.id}")
  end

  it 'renders comments of post' do
    expect(page.find("#comments-post-#{@post.id}").all('li').length).to eql(@post.comments.length)
  end

  it 'renders nº of likes a post has' do
    expect(page).to have_content("likes: #{@post.likes.length}")
  end

  it "redirects to user/1/post/x when clicked on a post'" do
    page.find("#post-#{@post.id}").click
    expect(current_path).to eql(user_post_path(@user, @post))
  end
end
