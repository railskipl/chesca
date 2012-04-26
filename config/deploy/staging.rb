set :deploy_to, "/var/www/#{application}"

set :branch, 'development'

set :user, 'deploy'
set :password, 'browzhost'
set :use_sudo, false

server 'browz.net', :app, :web, :db, :primary => true
