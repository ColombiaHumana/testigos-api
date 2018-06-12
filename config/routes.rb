# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do

  constraints subdomain: 'coordinadores' do
    devise_for :coordinadores, path: '/'
    root to: 'validate#index'
    get '/validacion', to: 'validate#show', as: :validacion
    get '/ayuda', to: 'validate#help', as: :help
    get '/validacion/:token', to: 'validate#edit_user', as: :edit_user
    patch '/validacion/:token', to: 'validate#update_user', as: :update_user
    patch '/descartado/:token', to: 'validate#reject_user', as: :reject_user

  end

  constraints subdomain: 'callcenter' do
    devise_for :callcenter_users, path: '/'
    root to: 'callcenter#index'
    get '/validacion', to: 'callcenter#show', as: :callcenter_validacion
    get '/ayuda', to: 'callcenter#help', as: :callcenter_help
    get '/validacion/:token', to: 'callcenter#edit_user', as: :callcenter_edit_user
    patch '/validacion/:token', to: 'callcenter#update_user', as: :callcenter_update_user
    patch '/descartado/:token', to: 'callcenter#reject_user', as: :callcenter_reject_user
  end

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
    get 'tables', to: 'api/tables#show', as: :tables_show
    post 'issue' => 'api/reports#create', as: :create_issue
    post 'password_reset' => 'api/password#create', as: :password_reset
    post 'user_token' => 'user_token#create', as: :user_token
    post 'user' => 'api/user#update', as: :user_online
    post 'user/email' => 'api/user#email', as: :user_email
    post 'results' => 'api/round#create', as: :create_result
  end
  post '/' => 'application#index', format: 'html'
  get '/token/:token' => 'reset_mail#update', as: :token_show
  get '/verify/:token' => 'reset_mail#validation', as: :validation
  authenticate :admin_user do
    mount Sidekiq::Web => 'admin/sidekiq'
  end
  %w[404 422 500 503].each do |code|
    get code, to: 'errors#show', code: code
  end

  post "/webhook/#{Rails.application.credentials.postal_api}",
       to: 'webhook#handle'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/t/:token/accept', to: 'confirmation#accept', as: :confirmation_accept
  get '/t/:token/reject', to: 'confirmation#reject', as: :confirmation_reject
  get '/t/:token/edit', to: 'confirmation#edit', as: :confirmation_edit
  get '/t/:token/coordinador',
      to: 'confirmation#coordinator', as: :confirmation_coordinator
  patch '/t/:token', to: 'confirmation#update', as: :confirmation_update
  patch '/t/:token/coordinador', to: 'confirmation#update_coordinator',
        as: :confirmation_update_coordinator
  get '/t/:token/gracias', to: 'confirmation#thanks', as: :confirmation_thanks
  get '/t/gracias_coordinador',
      to: 'confirmation#thanks_coordinator',
      as: :confirmation_thanks_coordinator
end
