Rails.application.routes.draw do
  get 'organizations/index'
  get 'sessions/new'

  root   'static_pages#home'
  get 	 'help'    						=> 'static_pages#help'
  get	 'organizations'				=> 'organizations#index'
  get	 'signup'  						=> 'users#new'
  get	 'events/new'					=> 'events#new'
  get	 'organizations/:id/articles'	=> 'articles#index'
  get    'login'   						=> 'sessions#new'
  post   'login'   						=> 'sessions#create'
  delete 'logout'  						=> 'sessions#destroy'
  
  resources :participations, only: [:create, :destroy, :update]
  resources :events, only: [:index, :show, :create] do
    resources :pictures, only: [:create]
	member do
		get :participants
	end
  end
  resources :users do
    member do
      get :following, :followers, :events, :participations
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :organizations do
	resources :articles, shallow: true do
	  resources :comments
	end
  end
end
