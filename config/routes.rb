Dun::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'accomplishments#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
  end

  resources :teams

  resources :accomplishments do
    resources :likes
    resources :comments
  end

  resources :users
end
