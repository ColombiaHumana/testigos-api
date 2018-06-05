# frozen_string_literal: true

namespace :users do
  task_lists = %i[
    coordinador
    emails
    invitation
    load
    load_email
    mautic
    phones
  ]

  task_lists.each do |task_name|
    desc %(Run #{task_name})
    task task_name do
      on roles(:app) do
        within current_path.to_s do
          with rails_env: fetch(:stage).to_s do
            execute :rake, "users:#{task_name}"
          end
        end
      end
    end
  end
end
