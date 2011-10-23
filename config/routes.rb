Trekking::Application.routes.draw do
  resources :routes

  root to: "application#index"
end
