Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :groups do
  	resources :posts
  	member do
  		post :join
  		post :quit
  	end
  end
  root 'groups#index'
end
