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

  end
end
