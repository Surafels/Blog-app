require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Tom', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Mission Impossible', text: 'Fallout', comments_counter: 0) }
  let(:like) { Like.create(user:, post:) }

  it 'should show an error if likes_counter is negative' do
    post.likes_counter = -2
    expect(post).not_to be_valid
  end

  it 'should be valid when likes_counter is zero' do
    post.likes_counter = 0
    expect(post).to be_valid
  end

  it 'should be valid when likes_counter is positive' do
    post.likes_counter = 2
    expect(post).to be_valid
  end
end
