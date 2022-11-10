RSpec.describe 'users/index.html.erb', type: :system do
  before do
    driven_by(:rack_test)
  end

  before :each do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    visit users_path
  end

  it 'loads the page with correct h1' do
    expect(page).to have_css('h1', text: 'List of Geeks')
  end

  it 'loads user names correctly into the page' do
    expect(page).to have_content('Tom', count: 1)
    # same as => expect(page).to have_css("h3", text: "Tom")
    expect(page).to have_css('img', count: 1)
    expect(page).to have_content("nº of posts: #{@user.posts.length}")
  end
  # it "redirects to user/1/posts when clicked on 'Show all posts' button" do
  #   click_link "Ana" # too many users with same name
  #   expect(current_path).to eql(user_path(User.first))
  # end
end

# include RSpecHtmlMatchers
