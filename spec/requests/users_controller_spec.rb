require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let!(:user) { User.create(name: 'Tom', photo_url: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  describe 'GET /index' do
    it 'returns a correct and successful response' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is the list of posts for the user:')
    end
  end

  describe 'GET/show' do

    it 'returns a correct and successful response' do
     get users_path(user.id)
    expect(response).to have_http_status(:success)
    expect(response.status).to eq(200)
    end

    it 'renders the show template' do
      get users_path(user.id)
      expect(response.body).to include('Here is the list of posts for the user:')
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is the list of posts for the user:')
    end
  end
end
