Rails.application.routes.draw do
  get 'organizations/index'

  get 'sessions/new'

  root   'static_pages#home'
  get 	 'help'    			=> 'static_pages#help'
  get	 'organizations'	=> 'organizations#index'
  get	 'signup'  			=> 'users#new'
  get    'login'   			=> 'sessions#new'
  post   'login'   			=> 'sessions#create'
  delete 'logout'  			=> 'sessions#destroy'
  resources :users
  resources :organizations
end
