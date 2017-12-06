Rails.application.routes.draw do
  get 'dncs/print'
  get 'report/index'
  get 'report/print'
  get 'report/history'
  resources :report
  root 'report#index'

  resources :dncs
  resources :terrouts
  resources :terrins
  resources :terrs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
