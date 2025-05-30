Rails.application.routes.draw do
  devise_for :users
  root to: "hairs#index"

  # Cart Items routes for creating/updating/deleting individual items
  resources :cart_items, only: [:create, :update, :destroy]

  # Cart routes for showing the cart and checkout flow
  resource :cart, only: [:show] do
    get 'checkout', to: 'carts#checkout'
    get 'success', to: 'carts#success'
    get 'cancel', to: 'carts#cancel'
  end

  resources :hairs do
    resources :reviews, only: [:new, :create, :edit, :update]
  end
end
