require "sidekiq/web"

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    # devise_for :users
    put "articles/update_aasm/:id", to: "articles#update_aasm"
    put "categories/update_many", to: "categories#update_many"
    get "comments/all_deleted", to: "comments#all_deleted"
    get "users/previous_versions/:id", to: "users#previous_versions"
    resources :categories, only: [:index]
    resources :login, only: [:create]
    resources :comments, only: [:destroy]
    resources :users, only: [:create, :update] do
      put "roles/update_many", to: "users/roles#update_many"
    end
    resources :articles, only: [:index, :show, :create] do
      resources :comments, only: [:index], controller: "articles/comments"
    end
  end
end
