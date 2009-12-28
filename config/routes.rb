ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :member => [:reply_to]

  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session, :member => [:logout_twitter]
  map.root :controller => "user_sessions", :action => "new"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
end
