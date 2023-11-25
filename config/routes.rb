Rails.application.routes.draw do
  resources :category_expenses
  resources :expenses
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  devise_for :users

  # resources :categories
  resources :users do
    resources :categories do
      resources :expenses
    end
  end
   
  # Defines the root path route ("/")
  root "categories#index"
end
