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
end
