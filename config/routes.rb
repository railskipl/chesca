ActionController::Routing::Routes.draw do |map|
  

  # map.resources :vouchers
  map.root :controller => 'main'

  map.resources :products, :only => [:index, :show]
  map.resources :pages, :only => [:show]
  map.resources :departments, :only => [:index, :show]
  map.resources :styles, :only => [:index, :show]
  map.resources :users
 #A map.connect '/admin/product/:id/delete', :controller=>'admin/products', :action=>'destroy'
 # map.connect '/admin/product/:id/edit', :controller=>'admin/products', :action=>'edit'
  map.resources :cart_items, :as => 'cart', :member => {:add_voucher => :post, :gift_card_entry => :post, :select_delivery_option => :post, :disjoin_voucher => :get, :remove_giftcard => :get}

  map.resource :admin, :controller => 'admin/panel', :only => :show

  map.resource :payment, :only => [:create], :member => {:confirm => [:get, :post], :cancel => [:get, :post], :complete => :post}

  map.namespace :admin do |admin|
    admin.resource :session, :controller => 'session', :only => [:new, :create, :destroy]

    admin.resources :products, :except => :show, :collection => {:sort => :post, :addimages => :get,:top100 => :get, :display_order => [:get, :post],:in_place_edit=>:any } do |products|
      products.resources :product_images
    end
    admin.resources :product_images
    admin.resources :departments, :except => :show
    admin.resources :styles, :except => :show
    admin.resources :sizes, :except => :show
    admin.resources :orders
    admin.resources :posts
    admin.resources :vouchers, :except => :show
    admin.resources :locations
    admin.resources :news_feeds
    admin.resources :pages
    admin.resources :company_pages
    admin.resources :home_pages
    admin.resources :looks
    admin.resources :imagepages
    admin.resources :colors, :except => :show
    admin.resources :giftcards, :except => :show
    admin.resources :designers, :except => :show
    admin.resources :our_companies
    admin.resources :privacy_policies
    admin.resources :medias
    admin.resources :users
    admin.resources :footerpages
  end

  map.sizing_chart 'sizing-chart', :controller => 'static', :action => 'sizing_chart'
  map.locations 'locations', :controller => 'static', :action => 'locations'
  map.contact_us 'contact-us', :controller => 'static', :action => 'contact_us'
  map.our_company 'our-company', :controller => 'static', :action => 'our_company'
  map.returns 'returns', :controller => 'static', :action => 'returns'
  map.return_policy 'return_policy', :controller => 'static', :action => 'return_policy'
  map.site_map 'site-map', :controller => 'static', :action => 'site_map'
  map.privacy_policy 'privacy-policy', :controller => 'static', :action => 'privacy_policy'
  map.ask_us 'ask-us', :controller => 'static', :action => 'ask_us'

  map.new_arrivals 'new-arrivals', :controller => 'products', :action => 'new_arrivals'
  map.sales 'sales', :controller => 'products', :action => 'sales'

  map.resources :posts, :as => 'fashion-news', :only => [:index, :show], :collection => {:editor_newsletter => :get, :chesca_trends => :get, :archived_looks=>:get}
  map.resources :designers, :as => 'designer-index', :only => [:index, :show]
  map.resources :media, :as => 'in-the-media', :only => [:index], :collection => {:advertising => :get, :as_seen_in=> :get, :events=> :get, :press=> :get, :videos=> :get}
  map.resources :looks, :as => 'looks-we-love', :only => [:index, :show], :collection => {:archived_looks=>:get}
  map.send_to_a_friend 'products/:id/send-to-a-friend', :controller => 'products', :action => 'send_to_a_friend'
  map.resources :footerpages, :as => 'footer-pages', :only => [:show]
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  # map.resources :products

  # Sample resource route with options:
  # map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  # map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  # map.resources :products do |products|
  # products.resources :comments
  # products.resources :sales, :collection => { :recent => :get }
  # end

  # Sample resource route within a namespace:
  # map.namespace :admin do |admin|
  # # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  # admin.resources :products
  # end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end