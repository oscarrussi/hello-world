require "sidekiq/web"

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => "/sidekiq"
 
  namespace :api do
    # devise_for :users
    resources :categories, only: [:index]
    resources :login, only: [:create]
    resources :users, only: [:create]
    resources :articles, only: [:show] do
    resources :comments, only: [:index], controller: "articles/comments"
  end
    put "categories/update_many", to: "categories#update_many"
  end
end
