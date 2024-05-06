Rails.application.routes.draw do
  # Users
  resources :users, only: [] do
    resources :posts, only: [:index, :create]
  end
  
  # Posts
  resources :posts, only: [] do
    resources :reviews, only: [:create, :index]
  end
  get '/top_posts', to: 'posts#top_posts' # List top posts
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
