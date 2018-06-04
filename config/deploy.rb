# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.10.2'

set :application, 'testigos-api'
set :repo_url, 'git@github.com:ColombiaHumana/testigos-api.git'
set :deploy_to, '/app'
set :ssh_options, verify_host_key: :secure
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/master.key',
  'vendor/divipol/users.csv',
  'vendor/divipol/emails.csv',
  'vendor/divipol/divipol_users.csv',
  'vendor/divipol/mautic.csv',
  'vendor/divipol/sample.csv'
)
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/cache',
  'public/uploads'
)
set :rvm_type, :user
set :pty, false
set :rvm_ruby_version, '2.5.0'
set :passenger_restart_with_touch, true
set :sidekiq_config, 'config/sidekiq.yml'
