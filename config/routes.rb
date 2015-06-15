Rails.application.routes.draw do
  mount SuperfeedrEngine::Engine => SuperfeedrEngine::Engine.base_path
  
  get 'organizations/index'
  get 'sessions/new'

  root   'static_pages#home'
  get 	 'help'    						=> 'static_pages#help'
  get	 'admin_board'					=> 'static_pages#admin_board'
  get	 'organizations'				=> 'organizations#index'
  get	 'signup'  						=> 'users#new'
  get	 'events/new'					=> 'events#new'
  get	 'organizations/:id/articles'	=> 'articles#index'
  get    'login'   						=> 'sessions#new'
  post   'login'   						=> 'sessions#create'
  delete 'logout'  						=> 'sessions#destroy'
  
  resources :favorite_organizations, only: [:create, :destroy]
  resources :participations, only: [:create, :destroy, :update]
  resources :events, only: [:index, :show, :create] do
    resources :videos, only: [:create]
    resources :pictures, only: [:create]
	resources :schedule_entries, only: [:create, :destroy]
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
