require 'capistrano/ext/multistage'

set :application, "chescasite"

set :default_stage, 'production'

# This is needed for interactive password prompting to work
default_run_options[:pty] = true

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :git
set :local_repository, File.join(File.dirname(__FILE__), '..')
set :repository, 'git@browz.net:chescasite2.git'

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
    run "chmod 777 #{current_path}/tmp/restart.txt"
  end

  desc "Change owner group for created directories"
  task :update_owner_group do
    sudo "chown -R deploy: #{deploy_to}"
  end

  desc "Create database"
  task :create_db do
    run "cd #{deploy_to}/current; RAILS_ENV=production rake db:create"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

  before "deploy:migrate", "deploy:create_db"
  after "deploy:setup", "deploy:update_owner_group"
end
