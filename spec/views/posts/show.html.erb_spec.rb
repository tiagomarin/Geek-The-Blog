RSpec.describe 'posts/show.html.erb', type: :system do
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
    visit user_post_path(@user, @post)
  end

  it 'renders post author name correctly' do
    expect(page).to have_content("Post #{@post.id} by #{@post.author.name}")
  end

  it 'renders post title correctly' do
    expect(page).to have_content('Hello Tom')
  end

  it 'renders post body correctly' do
    expect(page).to have_content('This is my first post')
  end

  it 'renders nº of comments the post has' do
    expect(page).to have_content("comments: #{@post.comments.length}")
  end

  it 'renders nº of likes the post has' do
    expect(page).to have_content("likes: #{@post.likes.length}")
  end

  it 'renders name of comment author' do
    expect(page).to have_content("#{@post.comments.first.author.name} :")
  end

  it 'renders name of comment author' do
    expect(page).to have_content(@post.comments.first.text.to_s)
  end
end
