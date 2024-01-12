require 'rails_helper'
RSpec.describe 'Post', type: :feature do
  before :each do
    @user1 = User.create!(name: 'David', photo_url: 'https://unsplash.com/photos/1.jpg', bio: 'Teacher from Mexico.',
                          posts_counter: 2)
    @post1 = Post.create!(author: @user1, title: 'First Post', text: 'First text', comments_counter: 2,
                          likes_counter: 2)
    @post2 = Post.create!(author: @user1, title: 'Second Post', text: 'Second text', comments_counter: 0,
                          likes_counter: 0)

    @comment1 = Comment.create!(post: @post1, user: @user1, text: 'hello David')
    @comment2 = Comment.create!(post: @post1, user: @user1, text: 'hello David')
    @like1 = Like.create!(post: @post1, author: @user1)
    @like2 = Like.create!(post: @post1, author: @user1)
  end
  describe 'Index page' do
    it "should display the user's profile picture" do
      visit user_posts_path(@user1)
      expect(page).to have_css("img[src*='https://unsplash.com/photos/1.jpg']")
    end
    it "should display the user's username" do
      visit user_posts_path(@user1)
      expect(page).to have_content(@user1.name)
    end
    it "should display the user's number of posts" do
      visit user_posts_path(@user1)
      expect(page).to have_content(@user1.posts_counter)
    end
    it "should display the post's title" do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post1.title)
    end
    it "should display some of the post's body" do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post1.text)
    end
    it 'should display the first comments on a post' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
    it 'should display the number of comments on a post' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post1.comments_counter)
    end
    it 'should display the number of likes on a post' do
      visit user_posts_path(@user1)
      expect(page).to have_content(@post1.likes_counter)
    end
    it 'Should display the section to create a new post' do
      visit user_posts_path(@user1)
      expect(page).to have_content('Create New Post')
    end

    it 'displays a section for pagination if there are more posts' do
      @user1 = User.create!(name: 'David', photo_url: 'https://unsplash.com/photos/1.jpg', bio: 'Teacher from Mexico.',
                            posts_counter: 2)

      30.times do
        Post.create!(
          author: @user1,
          title: 'Sample Post',
          text: 'Lorem ipsum dolor sit amet.',
          comments_counter: 0,
          likes_counter: 0
        )
      end

      visit user_posts_path(user_id: @user1.id)

      expect(page).to have_selector('.pagination', visible: true)
    end
    it 'should redirect to the post show page when clicking on a post' do
      visit user_posts_path(@user1)

      # Assuming there is at least one post
      first_post = @posts.first

      click_link(first_post.title)

      # Check if it redirects to the post show page
      expect(page).to have_current_path(user_post_path(@user1, first_post))
    end
  end
end
