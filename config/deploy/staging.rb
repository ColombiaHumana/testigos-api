# frozen_string_literal: true

server 'testigos-api', user: 'capistrano', roles: %w[app db web worker]
set :branch, 'staging'
