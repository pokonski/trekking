Trekking::Application.routes.draw do
  resources :routes do
    put 'update_waypoints', :on => :member
  end

  root to: "application#index"
end
