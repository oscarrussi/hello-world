require "sidekiq/web"

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => "/sidekiq"
 
  namespace :api do
    # devise_for :users
    put "articles/update_aasm", to: "articles#update_aasm"
    put "categories/update_many", to: "categories#update_many"
    get "comments/get_deleted", to: "comments#get_deleted"
    resources :categories, only: [:index]
    resources :login, only: [:create]
    resources :comments, only: [:destroy]
    resources :users, only: [:create] do
      put "roles/update_many", to: "users/roles#update_many"
    end
    resources :articles, only: [:index, :show, :create] do
      resources :comments, only: [:index], controller: "articles/comments"
    end
  end
end
