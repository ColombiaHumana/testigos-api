# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope '/api', defaults: { format: 'json' } do
    get 'news' => 'api/news#index', as: :news_index
    get 'user' => 'api/user#show', as: :user
    post 'issue' => 'api/reports#create', as: :create_issue
    post 'password_reset' => 'api/password#create', as: :password_reset
    post 'user_token' => 'user_token#create', as: :user_token
    post 'user' => 'api/user#update', as: :user_online
    post 'results' => 'api/results#create', as: :create_result
  end
  post '/' => 'application#index'
  get '/token/:token' => 'reset_mail#update', as: :token_show
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
