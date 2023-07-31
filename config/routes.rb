Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount ActionCable.server => '/cable'
  # Define the messages route
  get '/messages', to: 'messages#index', as: :messages
  get '/about', to: "pages#about"
  root "pages#home"
end
