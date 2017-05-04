Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users
  root to: "welcome#index"
  get 'search', to: 'welcome#search'

  concern :votable do
    resources :votes, only: [:create, :destroy]
  end

  resources :recipes, concerns: [:votable] do
    resources :ingredients, only: [:destroy]
    post 'moderation', to: 'recipes#set_state'
    post 'draft', to: 'recipes#set_state'
    post 'publish', to: 'recipes#set_state'
    resources :comments
  end

  resources :user_profiles
  resources :admin
end
