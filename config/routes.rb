ImaBold::Application.routes.draw do
  resources :products do
    collection do
      delete :destroy_selected
      post :ativate_selected
      get :deactivate_selected
      get :filter
    end
  end
  post :filter, to: "products#filter"
  post "destroy_selected" => "products#destroy_selected", :as => "destroy_selected",  via: [:delete]
  post "ativate_selected" => "products#ativate_selected", :as => "ativate_selected",  via: [:post]
  post "deactivate_selected" => "products#deactivate_selected", :as => "deactivate_selected",  via: [:post]
  match 'products/ativate_deactivate/:id', to: 'products#ativate_deactivate', via: [:post]

  root to: 'products#index'

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
