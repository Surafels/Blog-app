require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid when posts counter is not an integer' do
    user = User.new(name: 'John Isac', posts_counter: 'abc')
    expect(user).to_not be_valid
    expect(user.errors[:posts_counter]).to include('is not a number')
  end

  it 'is invalid when posts counter is less than zero' do
    user = User.new(name: 'John Isac', posts_counter: -1)
    expect(user.valid?).to be false
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  describe 'The most_recent_posts method' do
    it 'returns the most recent posts' do
      second_user = User.create(name: 'susu', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                bio: 'Teacher from Poland.')

      Post.create(author: second_user, title: 'Hello', text: 'This is my first post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my second post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my third post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my fourth post')
      Post.create(author: second_user, title: 'Hello', text: 'This is my fifth post')

      most_recent_posts = second_user.most_recent_posts
      expect(most_recent_posts).to eq(second_user.posts.order(created_at: :desc).limit(3))
    end
  end
end
