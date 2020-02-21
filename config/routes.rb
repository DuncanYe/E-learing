Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'courses#index'
  resource :courses

  namespace :admin, path: :make_backend_url_abstruse do
    root 'courses#index'

    resource :courses
    resource :orders
    resource :user_courses, only: [:index, :edit, :update]
  end
end
