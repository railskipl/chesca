set :deploy_to, "/var/www/#{application}/production"

set :branch, 'master'

set :user, 'deploy'
set :password, 'browzhost'
set :use_sudo, false

server "109.74.196.241", :app, :web, :db, :primary => true
