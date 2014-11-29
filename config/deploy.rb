# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'MyStackOverflow'
set :repo_url, 'https://github.com/bazoon/MyStackOverflow.git'


# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deployer/so'
set :deploy_user, 'deployer'

# Default value for :scm is :git
set :scm, :git


# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/private_pub.yml .env config/private_pub_thin.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}



namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart

 
end


namespace :private_pub do
  desc 'Start private_pub'
  task :start do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec thin -C config/private_pub_thin.yml start'
        end
      end
    end
  end
end

namespace :private_pub do
  desc 'Stop private_pub'
  task :stop do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec thin -C config/private_pub_thin.yml stop'
        end
      end
    end
  end
end

namespace :private_pub do
  desc 'ReStart private_pub'
  task :restart do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec thin -C config/private_pub_thin.yml restart'
        end
      end
    end
  end
end

# namespace :ts do
#   desc 'Start thinking sphinx'
#   task :start do
#     on roles(:app) do
#       within current_path do
#         with rails_env: fetch(:rails_env) do
#           execute :bundle, 'exec rake ts:start'
#         end
#       end
#     end
#   end
# end


 
after 'deploy:restart', 'private_pub:restart'
after 'deploy:restart', 'thinking_sphinx:restart'



