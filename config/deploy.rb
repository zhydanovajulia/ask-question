set :application, "ask-question"
set :repository,  "git@github.com:zhydanovajulia/ask-question.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, fetch(:branch, "master")
set :host, "maxtsap.fvds.ru"
set :user, "root"
set :deploy_to, "/var/www/apps"
# set :use_sudo, false

role :web, "maxtsap.fvds.ru"                          # Your HTTP server, Apache/etc
role :app, "maxtsap.fvds.ru"                  # This may be the same as your `Web` server
role :db,  "maxtsap.fvds.ru", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end