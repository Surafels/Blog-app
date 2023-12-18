Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
get 'users/:user_id/posts', to: 'posts#index', as: 'user_posts'
get 'users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
get 'users', to: 'users#index', as: 'users'
get 'users/:id', to: 'users#show', as: 'user'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
