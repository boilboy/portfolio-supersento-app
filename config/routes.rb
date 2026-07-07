Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sesions: 'users/sessions'
  }
  root 'tops#home'
end
