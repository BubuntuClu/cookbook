Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users
  root to: "welcome#index"

  concern :votable do
    resources :votes, only: [:create, :destroy]
  end

  resources :recipes, concerns: [:votable] do
    resources :ingredients, only: [:destroy]
    post 'send_to_moderation', to: 'recipes#send_to_moderation'
    post 'send_to_draft', to: 'recipes#send_to_draft'
    post 'send_to_publish', to: 'recipes#send_to_publish'
    resources :comments
  end

  resources :user_profiles
  resources :admin
end
