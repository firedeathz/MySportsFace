Rails.application.routes.draw do
  mount SuperfeedrEngine::Engine => SuperfeedrEngine::Engine.base_path
  get	 'auth/:provider/callback'		=> 'sessions#create'
  patch	 'auth/:provider/callback'		=> 'sessions#create'
  get	 'auth/failure'					=> redirect('/')
  get	 'signout'						=> 'sessions#destroy'
  
  get 'organizations/index'
  get 'sessions/new'

  root   'static_pages#home'
  get 	 'help'    						=> 'static_pages#help'
  get	 'about'						=> 'static_pages#about'
  get	 'admin_board'					=> 'static_pages#admin_board'
  get	 'organizations'				=> 'organizations#index'
  get	 'signup'  						=> 'users#new'
  get	 'events/new'					=> 'events#new'
  get	 'organizations/:id/articles'	=> 'articles#index'
  get    'login'   						=> 'sessions#new'
  post   'login'   						=> 'sessions#create_identity'
  delete 'logout'  						=> 'sessions#destroy'
  
  resources :sessions, only: [:create, :destroy]
  
  resources :favorite_organizations, only: [:create, :destroy]
  resources :participations, only: [:create, :destroy, :update]
  resources :events, only: [:index, :show, :create, :destroy] do
    resources :videos, only: [:create, :destroy]
    resources :pictures, only: [:create, :destroy]
	resources :schedule_entries, only: [:create, :destroy]
	resources :event_comments, only: [:create, :destroy] do
		member do
			post :star
			post :unstar
		end
	end
	member do
		get :participants
		post :star
		post :unstar
	end
  end
  resources :users do
    member do
      get :following, :followers, :events, :participations
    end
  end
  resources :microposts, only: [:create, :destroy] do
	member do
	  post :star
	  post :unstar
	end
  end
  resources :relationships, only: [:create, :destroy]
  resources :organizations do
    resources :articles, shallow: true do
	  resources :comments, only: [:create, :destroy] do
		member do
			post :star
			post :unstar
		end
	  end
	  member do
		post :star
		post :unstar
	  end
	end
  end
end
