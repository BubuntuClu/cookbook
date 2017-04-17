Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users
  root to: "welcome#index"

  concern :votable do
    resources :votes, only: [:create, :destroy]
  end

  resources :recipes, concerns: [:votable] do
    resources :ingredients, only: [:destroy]
    post 'moderation', to: 'recipes#state_handler'
    post 'draft', to: 'recipes#state_handler'
    post 'publish', to: 'recipes#state_handler'
    resources :comments
  end

  resources :user_profiles
  resources :admin
end
