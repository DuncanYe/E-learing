Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'courses#index'
  resources :courses, only: [:index]
  resources :user_courses, only: [:index, :new, :create]

  namespace :admin, path: :make_backend_url_abstruse do
    root 'courses#index'

    resources :courses
    resources :orders
    resources :user_courses, only: [:index, :edit, :update]
  end
end
