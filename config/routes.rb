Rails.application.routes.draw do

  devise_for :users
  # devise_for :users, controllers: { confirmations: 'confirmations' }

  devise_scope :user do
    root 'devise/sessions#new'
    # get '/user_sign_out', to: 'devise/sessions#new'
  end

  get '/user_sign_out', to: 'users#user_sign_out', as: :user_sign_out


  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
