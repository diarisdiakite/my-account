Rails.application.routes.draw do
  resources :expenses
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  devise_for :users
   
  # Defines the root path route ("/")
  root "users#index"
end
