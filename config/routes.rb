# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api', defaults: { format: 'json' } do
    post 'user_token' => 'user_token#create', as: :user_token
    get 'news' => 'api/news#index', as: :news_index
    post 'password_reset' => 'api/password#create', as: :password_reset
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
