Rails.application.routes.draw do

  resources :passengers 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  patch '/drivers/:id', to:  'drivers#change_availability', as: 'change_availability'
  resources :drivers
  
end
