Rails.application.routes.draw do
  get 'dncs/print'
  get 'report/index'
  get 'report/print'
  get 'report/history'
  get 'report/download'
  get 'admin', to: 'admin#index'
  post 'admin', to: 'admin#index'
  
  resources :report
  resources :dncs
  resources :terrouts
  resources :terrins
  resources :terrs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'report#index'
end
