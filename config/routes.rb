Trekking::Application.routes.draw do
  devise_for :users

  resources :routes do
    put 'update_waypoints', :on => :member
    get 'page/:page', :action => :index, :on => :collection
  end

  root to: "application#index"
end
