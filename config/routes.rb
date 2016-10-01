# frozen_string_literal: true
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'admin_panel'

  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope '(:locale)', locale: /en/ do
    root 'store#index'

    get 'store', to: 'store#store'
    get 'error', to: 'store#error'

    resource :cart, only: %i(show update) do
      delete 'empty'
    end

    resources :books, only: :show do
      resource :review, only: %i(new create)
      post 'order', to: 'order_items#create'
    end

    resources :authors, only: %i(show)
    resources :categories, only: %i(show)
    resources :addresses, only: %i(create update)
    resources :checkout, only: %i(index show update)

    resources :orders, only: %i(index show) do
      resources :order_items, path: 'item', as: :item, only: %i(create destroy)
    end

    match 'settings', to: 'settings#index', via: %i(get post patch), as: 'settings'

    devise_for :users, skip: :omniauth_callbacks, path_names: {
      sign_in: 'sign-in',
      sign_up: 'sign-up',
      sign_out: 'sign-out'
    }, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  end
end
