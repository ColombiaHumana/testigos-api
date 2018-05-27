namespace :divipol do
  desc 'Load divipol from csv'
  task :load do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "divipol:load"
        end
      end
    end
  end

  desc 'Load sample from csv'
  task :sample do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "divipol:sample"
        end
      end
    end
  end
end
