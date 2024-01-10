require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :each do
    @user1 = User.create!(name: 'John', photo_url: 'https://unsplash.com/photos/1.jpg', bio: 'Teacher from Mexico.',
                          posts_counter: 3)

    @post1 = Post.create!(author: @user1, title: 'First Post', text: 'First text', comments_counter: 0,
                          likes_counter: 0)
    @post2 = Post.create!(author: @user1, title: 'Second Post', text: 'First text', comments_counter: 0,
                          likes_counter: 0)
    @post3 = Post.create!(author: @user1, title: 'Third Post', text: 'First text', comments_counter: 0,
                          likes_counter: 0)
  end

  describe 'show' do
    it 'should display the use profile picture' do
      visit user_path(@user1)
      expect(page).to have_css("img[src*='https://unsplash.com/photos/1.jpg']")
    end

    it 'should display the username of the user' do
      visit user_path(@user1)
      expect(page).to have_content(@user1.name)
    end

    it 'should display the number of posts of the user' do
      visit user_path(@user1)
      expect(page).to have_content(@user1.posts_counter)
    end

    it 'should display the bio of the user' do
      visit user_path(@user1)
      expect(page).to have_content(@user1.bio)
    end

    it 'should display the user first 3 posts' do
      visit user_path(@user1)
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
    end

    it 'should have the button to display all posts' do
      visit user_path(@user1)
      expect(page).to have_link('See all posts')
    end

    it "should redirect me to the post's show page when clicking on the user's post" do
      visit user_path(@user1)
      click_link @post1.title
      expect(page).to have_current_path(user_post_path(@user1, @post1))
    end

    it "should redirect me to the user's post's index page when clicking on the 'See all posts' button" do
      visit user_path(@user1)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
