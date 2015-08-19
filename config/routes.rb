Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  namespace :admin do
    root 'home#index'

    resources :users do
      member do
        post 'unit' => 'users#add_unit'
        delete 'unit/:unit_id' => 'users#remove_unit', as: 'destroy_unit'
      end
    end
    # get 'users' => 'users#index'
    # get 'users/:id' => 'users#show'
    # post 'users/:id' => 'nowhere#index'
    # put 'users/:id/'

    get 'documents' => 'nowhere#index'
    get 'documents/:id' => 'nowhere#index'

  end

  # View residents and update profile
  get 'residents/' => 'residents#index'
  get 'residents/me'
  get 'residents/me/aws-callback' => 'residents#aws_upload_callback'
  get 'residents/:id' => 'residents#show', as: 'residents_show'
  patch 'residents/update'


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
