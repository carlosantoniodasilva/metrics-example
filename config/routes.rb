MetricsExample::Application.routes.draw do
  resources :customers
  resources :orders do
    resources :items, only: [:new, :create, :edit, :update, :destroy], controller: 'orders/items'
  end
  resources :products

  root to: 'home#index'
end
