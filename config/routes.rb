MetricsExample::Application.routes.draw do
  resources :orders

  resources :customers
  resources :products

  root to: 'home#index'
end
