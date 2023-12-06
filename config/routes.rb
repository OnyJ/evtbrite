Rails.application.routes.draw do
  devise_for :users 
  resources :profiles
  resources :events
  resources :attendances
  
  post "events/subscribe/:id", to: "subscribes#create", as: "subscribes"
  get "events/subscribe/:id", to: "subscribes#free_subscribe", as: "free_subscribe" 
 
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
