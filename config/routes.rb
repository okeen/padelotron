Padelotron::Application.routes.draw do
  
  resources :playgrounds
  resources :places do
    resources :playgrounds
  end
  resources :achievements

  get "home" => "home#home", :as => "home"

  resources :games do
    resource :result
  end

  get "confirmations/:code" => "confirmations#show", :as => "show_confirmation"
  post "confirmations/:code" => "confirmations#update", :as => "update_confirmation"
  put "confirmations/:code" => "confirmations#update", :as => "update_confirmation"

  post "confirmations/:code/do" => "confirmations#do_confirmation", :as => "do_confirmation"

  get "teams/available" => "teams#available", :as => "available_teams"
  resources :teams

  post "player_session/facebook/login" => "players/facebook_sessions#login", :as => "facebook_js_login"
  post "player_session/facebook/logout" => "players/facebook_sessions#logout", :as => "facebook_js_logout"

  devise_for :players, :controllers => { :omniauth_callbacks => "players/omniauth_callbacks" }
  devise_scope :player do
    get '/auth/:provider/callback' => 'players/omniauth_callbacks#facebook'
    get '/players/auth/:provider' => 'players/omniauth_callbacks#passthru'
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end
  resources :players

  devise_for :customers, :controllers => { :registrations => "customers",
    :confirmation => "customers/confirmations"}
  devise_scope :customers do
    #post '/customers/' => 'customers#create'
  end

  get "subscriptions/create" => "subscriptions#create"
  get "subscriptions/update" => "subscriptions#update"

  namespace :customers do
      get "agenda/show", :to => "agenda#show", :as => "agenda"
      get "agenda/games", :to => "agenda#games", :as => "agenda_games"

  end

  resources :customers do
    resources :subscriptions
  end
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "teams#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
