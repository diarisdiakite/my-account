Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  devise_for :users

  resources :cities
  resources :cars, only: [:index, :view]

  resources :users do
    resources :categories do
      resources :expenses
    end
    resources :cars do
      resources :reservations
    end
  end
    
  # Defines the root path route ("/")
  root "splash#index"
end
