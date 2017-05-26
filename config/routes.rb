Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  devise_for :users, controllers: { confirmations: 'confirmations', omniauth_callbacks: 'omniauth_callbacks' } do
    member do
        get :conrifm_email
      end
    end
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

  resources :comments do
    resources :discussions
  end

  resources :user_profiles do
    post 'add_friend', to: 'user_profiles#add_friend'
    post 'remove_friend', to: 'user_profiles#remove_friend'
    resources :chat_messages
  end
  
  resources :admin
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:patch], :as => :finish_signup

  mount ActionCable.server => '/cable'
end
