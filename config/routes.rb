# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :coordinators
  devise_for :users
  get '/' => 'register#new', as: :user
  get '/iframe' => 'register#iframe', as: :iframe
  get '/departments' => 'register#get_department'
  get '/municipalities/:department_id' => 'register#get_municipality'
  get '/zones/:municipality_id' => 'register#get_zone'
  get '/posts/:zone_id' => 'register#get_post'
  post '/' => 'register#create', as: :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope '/api', defaults: { format: 'json' } do
    get 'news' => 'api/news#index', as: :news_index
    get 'user' => 'api/user#show', as: :user_show
    post 'issue' => 'api/reports#create', as: :create_issue
    post 'password_reset' => 'api/password#create', as: :password_reset
    post 'user_token' => 'user_token#create', as: :user_token
    post 'user' => 'api/user#update', as: :user_online
    post 'user/email' => 'api/user#email', as: :user_email
    post 'results' => 'api/results#create', as: :create_result
  end
  post '/' => 'application#index', format: 'html'
  get '/token/:token' => 'reset_mail#update', as: :token_show
  get '/verify/:token' => 'reset_mail#validation', as: :validation
  authenticate :admin_user do
    mount Sidekiq::Web => 'admin/sidekiq'
  end
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  post "/webhook/#{Rails.application.credentials.postal_api}" => 'webhook#handle'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/coordinadores' => 'validate#index', as: :coordinator_root
end
