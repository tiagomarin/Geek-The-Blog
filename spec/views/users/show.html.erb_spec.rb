RSpec.describe 'users/show.html.erb', type: :system do
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
    visit user_path(@user)
  end

  it 'renders user images' do
    expect(page).to have_css('img', count: 1) # image
  end

  it 'loads user name correctly into the page' do
    expect(page).to have_css('h3', text: 'Tom') # same as => expect(page).to have_content('Tom')
  end

  it 'renders nº of posts user has written' do
    expect(page).to have_content("nº of posts: #{@user.posts.length}")
  end

  it 'renders user bio correctly' do
    expect(page).to have_css('h3', text: 'Bio')
    expect(page).to have_css('p', text: 'Teacher from Mexico.')
  end

  it 'renders only 3 posts' do
    expect(page.find('#list-of-posts').all('li').length).to eql(3)
  end

  it 'renders nº of comments a post has' do
    expect(page).to have_content("comments: #{@post.comments.length}")
  end

  it 'renders nº of likes a post has' do
    expect(page).to have_content("likes: #{@post.likes.length}")
  end

  it "renders the 'Show all posts' button on page" do
    expect(page).to have_css('button', text: 'Show all posts')
  end

  it "redirects to user/1/post/x when clicked on a post'" do
    page.find("#post-#{@post.id}").click
    expect(current_path).to eql(user_post_path(@user, @post))
  end

  it "redirects to user/1/posts when clicked on 'Show all posts' button" do
    click_link 'Show all posts'
    expect(current_path).to eql(user_posts_path(User.first))
    # same as expect(page).to have_current_path(user_posts_path(User.first))
  end

  it 'renders post title correctly' do
    expect(page).to have_content('Hello') # post title
  end
end

# include RSpecHtmlMatchers
