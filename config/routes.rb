Rails.application.routes.draw do

  root "home#main"
  resources :users, except: [:index] do
    get "/schedule.json" => "users#managementcalendar"
    resources :events, except: [:show, :index]
    resources :parkingspots, except: [:index, :show]
  end

  get "/events/search" => "events#search", as: :search

  resources :events, only: [:show, :index] do
    resources :parkingspots, only: [] do
      resources :rentals, only: [:new, :create, :update] do
        get "/charges/new" => "rentals#newcharge"
        post "/charges" => "rentals#createcharge"
      end
    end
  end

  resources :parkingspots, only: [:show, :index] do
      resources :rentals, only: [] do
        get "/charges/new" => "rentals#noneventnewcharge"
        post "/charges" => "rentals#noneventcreatecharge"
      end
    get "/schedule.json" => "parkingspots#calendar"
    get "/rentals" => "rentals#nonEventRental"
    post "/rentals" => "rentals#nonEventRental"
  end


  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :parkingspots
    end
  end


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
