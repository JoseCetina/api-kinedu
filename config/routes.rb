Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :tasks

  root "tasks#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
