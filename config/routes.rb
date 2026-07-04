Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'

  resources :users, only: %i[show]
  get 'mypage', to: 'users#show', as: :mypage

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root 'tops#home'
end
