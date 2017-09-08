Rails.application.routes.draw do
  root 'report#index'
  resources :report

  resources :dncs
  resources :terrouts
  resources :terrins
  resources :terrs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
