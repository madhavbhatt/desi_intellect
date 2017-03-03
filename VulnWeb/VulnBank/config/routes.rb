Rails.application.routes.draw do

	resources :users
	resources :accounts
	resources :deposits
	resources :transfers
	resources :withdrawals
	resources :transaction
	resources :borrows

	root 'static_pages#home'
	get '/help', to: 'static_pages#help'
	get '/about', to: 'static_pages#about'
	get '/contact', to: 'static_pages#contact'
	get '/signup', to: 'users#new'
	get '/friends', to: 'users#friends'
	get 'friendships/create'
	get 'friendships/accept'
	get 'friendships/decline'
	get 'friendships/cancel'
	get 'borrows/cancel'
	get 'borrows/accept/:id', to: 'borrows#accept'
	get 'borrows/decline/:id', to: 'borrows#decline'
	post '/accounts/activate/:id', to: 'accounts#activate'
	post '/accounts/close/:id', to: 'accounts#close'
    get '/deposits/approve/:id', to: 'deposits#approve'
    get '/deposits/decline/:id', to: 'deposits#decline'
    get '/withdrawals/approve/:id', to: 'withdrawals#approve'
    get '/withdrawals/decline/:id', to: 'withdrawals#decline'
    get '/transfers/approve/:id', to: 'transfers#approve'
    get '/transfers/decline/:id', to: 'transfers#decline'
	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

	
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
	
end