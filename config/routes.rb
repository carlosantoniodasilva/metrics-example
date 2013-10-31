MetricsExample::Application.routes.draw do
  resources :customers
  resources :products

  root to: 'home#index'
end
