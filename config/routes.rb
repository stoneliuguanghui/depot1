Rails.application.routes.draw do
  match '/admin', to: 'admin#index',via: 'get'
  match '/logup', to: 'users#new',via: 'get'
  match '/logup', to: 'users#new',via: 'post'
  match '/login', to: 'sessions#new',via: 'post'
  match '/login', to: 'sessions#new',via: 'get'

  match '/logout', to: 'sessions#destroy',via: 'delete' 
  match '/signup', to: 'merchants#new',via: 'get'
  match '/signin', to: 'merchantssessions#new',via: 'get'

	root :to=>'store#index',:as=>'store'
  resources :merchants
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :orders
  resources :line_items
  resources :carts

  resources :products do
  	get :who_bought, :on=>:member
  end
  
   
end
		