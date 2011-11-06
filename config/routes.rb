Trekking::Application.routes.draw do
  devise_for :users

  resources :routes do
    post 'search', :on => :collection
    get 'near/:address', :on => :collection, :action => :near, :as => "near"
    put 'update_waypoints', :on => :member
    get 'page/:page', :action => :index, :on => :collection
  end

  root to: "application#index"
end
