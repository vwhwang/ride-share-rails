Rails.application.routes.draw do

  get 'welcome/index', to: 'welcome#index', as: 'welcome'
  root to: 'welcome#index'
  resources :passengers 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :drivers

  patch '/drivers/:id/change_availability', to:  'drivers#change_availability', as: 'change_availability'


  post '/passengers/:id', to: 'passengers#addtrip', as: 'addtrip'


end
