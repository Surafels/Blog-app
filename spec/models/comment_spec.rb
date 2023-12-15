require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Surafi', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'The sky', text: 'Blue sky', likes_counter: 0) }

  describe 'validations' do
    it 'should validate presence of text' do
      comment = Comment.create(post:, user:, text: 'Hello')
      expect(comment).to be_valid
    end

    it 'is invalid if comments_counter is negative' do
      post.comments_counter = -1
      expect(post).to_not be_valid
    end

    it 'should be valid when comments_counter is zero' do
      post.comments_counter = 0
      expect(post).to be_valid
    end

    it 'should be valid when comments_counter is positive' do
      post.comments_counter = 1
      expect(post).to be_valid
    end
  end
end
