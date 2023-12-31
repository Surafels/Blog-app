require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  user = User.create(name: 'Tom', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico')
  post = Post.create(author: user, title: 'The balck lions ', text: 'Hello', likes_counter: 0, comments_counter: 0)

  describe 'GET /index' do
    it 'returns a correct and successful response' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user_id: user.id)
      expect(response.body).to include('Here is the list of posts for the user:')
    end
  end

  describe 'GET /show' do
    it 'returns a correct and successful response' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include('Here is the list of posts for the user:')
    end
  end
end
