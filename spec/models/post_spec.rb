require 'rails_helper'

RSpec.describe Post, type: :model do
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
end
