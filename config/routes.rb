Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users
  root to: "welcome#index"

  resources :recipes do
    resources :ingredients, only: [:destroy]
    post 'send_on_moderation', to: 'recipes#send_on_moderation'
  end

  resources :user_profiles
end
