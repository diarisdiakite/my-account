Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  devise_for :users

  resources :users do
    resources :categories do
      resources :expenses, shallow: true
    end
  end
    
  # Defines the root path route ("/")
  root "categories#index"
end
