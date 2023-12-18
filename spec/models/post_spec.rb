require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Tom', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'The lion king', text: 'Nice', likes_counter: 0) }
  it 'is invalid without a title' do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'title should not be too long' do
    post = Post.new(title: 'a' * 251)
    expect(post).to_not be_valid
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'is invalid when comments counter is not an integer' do
    post = Post.new(title: 'John Isaac', comments_counter: 'abc')
    expect(post).to_not be_valid
    expect(post.errors[:comments_counter]).to include('is not a number')
  end

  it 'is invalid when comments counter is less than zero' do
    post = Post.new(title: 'John Isaac', comments_counter: -1)
    expect(post).to_not be_valid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is invalid when likes counter is not an integer' do
    post = Post.new(title: 'John Isaac', likes_counter: 'abc')
    expect(post).to_not be_valid
    expect(post.errors[:likes_counter]).to include('is not a number')
  end

  it 'is invalid when likes counter is less than zero' do
    post = Post.new(title: 'John Isaac', likes_counter: -1)
    expect(post).to_not be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  describe 'after_save ' do
    it 'it should update the author posts counter' do
      post = Post.create(author: user, title: 'The lion king', text: 'Nice', likes_counter: 0,
                         comments_counter: 0)
      expect { post.save }.to change { user.posts_counter }.by(1)
    end
  end

  describe 'most_recent_comments' do
    it 'should return the most recent comments based on the limit number' do
      user = User.create(name: 'Tom', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'The lion king', text: 'Nice', likes_counter: 0,
                         comments_counter: 0)
      comment1 = Comment.create(user:, post:, text: 'Comment 1')
      comment2 = Comment.create(user:, post:, text: 'Comment 2')
      comment3 = Comment.create(user:, post:, text: 'Comment 3')
      comment4 = Comment.create(user:, post:, text: 'Comment 4')
      comment5 = Comment.create(user:, post:, text: 'Comment 5')

      expect(post.most_recent_comments(1)).to eq([comment5])
      expect(post.most_recent_comments(2)).to eq([comment5, comment4])
      expect(post.most_recent_comments(3)).to eq([comment5, comment4, comment3])
      expect(post.most_recent_comments(4)).to eq([comment5, comment4, comment3, comment2])
      expect(post.most_recent_comments(5)).to eq([comment5, comment4, comment3, comment2, comment1])
    end
  end
end
