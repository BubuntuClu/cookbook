Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users
  root to: "recipes#index"

  resources :recipes do
    resources :ingredients, only: [:destroy]
  end
end
