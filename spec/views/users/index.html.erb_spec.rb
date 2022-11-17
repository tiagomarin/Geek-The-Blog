RSpec.describe 'users/index.html.erb', type: :system do
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
    @post3 = Post.create(author: @user2, title: 'Bye', text: 'This is my first post')
    @post_counter += 1
    Comment.create(post_id: @post.id, author_id: @user2.id, text: 'I really like your idea.')
    Like.create(post_id: @post.id, author_id: @user2.id)
    visit users_path
  end

  it 'loads the page with correct h1' do
    expect(page).to have_css('h1', text: 'List of Geeks')
  end

  it 'loads user names correctly into the page' do
    expect(page).to have_content('Tom', count: 1)
    expect(page).to have_content('Ana', count: 1)
  end

  it 'loads user picture correctly into the page' do
    expect(page).to have_css('img', count: 2)
  end

  it 'loads user nº of posts each user has correctly into the page' do
    expect(page).to have_content("nº of posts: #{@user.posts.length}")
  end

  it "redirects to user/1/posts when clicked on 'Show all posts' button" do
    click_link 'Tom'
    expect(current_path).to eql(user_path(User.first))
  end
end
