MetricsExample::Application.routes.draw do
  resources :customers

  root to: 'home#index'
end
