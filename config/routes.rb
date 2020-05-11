Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'welcome/index', to: 'welcome#index', as: 'welcome'
  root to: 'welcome#index'
  resources :passengers 
  # resources :passengers do 
  #   resources :trips , only: [:new]
  # end 


  post '/passengers/:id', to: 'passengers#addtrip', as: 'addtrip'

  resources :drivers
  patch '/drivers/:id/change_availability', to:  'drivers#change_availability', as: 'change_availability'

  resources :trips
end
