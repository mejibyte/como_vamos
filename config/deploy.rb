# -*- coding: utf-8 -*-
set :user, "comovamos"

set :scm, :git
set :scm_verbose, true
set :repository,  "git@github.com:andmej/como_vamos.git"
set :branch, "master"
set :deploy_via, :checkout
set :rails_env, "production"

# ssh_options[:forward_agent] = true
# default_run_options[:pty] = true

set :deploy_to, "/home/#{user}/app"

role :app, "nhocki.com"
role :web, "nhocki.com"
role :db,  "nhocki.com", :primary => true
set :use_sudo,  false

namespace :passenger do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  desc "Restart the Passenger system."
  task :restart, :roles => :app do
    passenger.restart
  end

  desc "Creates symbolic links to some config files"
  task :symlink_config_files do
    run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/smtp.yml #{current_path}/config/smtp.yml"
    run "ln -nfs #{shared_path}/uploads #{current_path}/public/uploads"
  end
end


after "deploy", "deploy:symlink_config_files"
