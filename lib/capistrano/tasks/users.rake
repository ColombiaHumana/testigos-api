namespace :users do
  desc 'Load divipol from csv'
  task :load do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "users:load"
        end
      end
    end
  end

  task :emails do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "users:emails"
        end
      end
    end
  end

  task :load_email do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "users:load_email"
        end
      end
    end
  end

  task :invitation do
    on roles(:app) do
      within current_path.to_s do
        with rails_env: fetch(:stage).to_s do
          execute :rake, 'users:invitation'
        end
      end
    end
  end
  task :mautic do
    on roles(:app) do
      within current_path.to_s do
        with rails_env: fetch(:stage).to_s do
          execute :rake, 'users:mautic'
        end
      end
    end
  end
  task :coordinador do
    on roles(:app) do
      within current_path.to_s do
        with rails_env: fetch(:stage).to_s do
          execute :rake, 'users:coordinador'
        end
      end
    end
  end
end
