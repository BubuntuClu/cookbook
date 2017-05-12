lock "3.8.1"

set :application, "cookbook"
set :repo_url, "git@github.com:BubuntuClu/cookbook.git"

set :deploy_to, "/home/deployer/cookbook"
set :deploy_user, 'deployer'

append :linked_files, "config/database.yml", ".env"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

namespace :deploy do 
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
