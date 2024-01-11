require 'rails_helper'
RSpec.describe 'Post', type: :feature do
  before :each do
    @user1 = User.create!(name: 'David', photo_url: 'https://unsplash.com/photos/1.jpg', bio: 'Teacher from Mexico.',
                          posts_counter: 1)
    @post1 = Post.create!(author: @user1, title: 'First Post', text: 'First text', comments_counter: 2,
                          likes_counter: 1)
    @comment1 = Comment.create!(post: @post1, author: @user1, text: 'Hello David!')
    @comment2 = Comment.create!(post: @post1, author: @user1, text: 'Hello David!')
    @like1 = Like.create!(post: @post1, author: @user1)
  end

end
