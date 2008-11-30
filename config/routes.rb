ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource :session
  map.resources :judges do |judge|
    judge.resources :problems, :only => :new
  end
  map.resources :problems, :except => :new do |problem|
    problem.resources :solutions, :only => :new
  end


  map.resources :solutions, :except => [:new, :show, :index]
  map.root :controller => "home", :action => "index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
