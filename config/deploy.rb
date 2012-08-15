require "bundler/capistrano"    
set :rvm_ruby_string, 'ruby-1.9.3-p125@rails3-cx'
set :rvm_type, :system # defaults to using a user installation of rvm
require "rvm/capistrano"

set :application, "ask-question"
set :repository,  "git@github.com:zhydanovajulia/ask-question.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, fetch(:branch, "master")
set :host, "maxtsap.fvds.ru"
set :user, "admin"
set :deploy_to, "/var/www/apps"
ssh_options[:forward_agent] = true
set :use_sudo, false

set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
set :ip, 'maxtsap.fvds.ru'

role :web, "#{user}@#{ip}"                          # Your HTTP server, Apache/etc
role :app, "#{user}@#{ip}"                  # This may be the same as your `Web` server
role :db,  "#{user}@#{ip}", :primary => true # This is where Rails migrations will run

set :keep_releases, 5

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

before "deploy:assets:precompile", :bundle_install

after "deploy:update_code", :bundle_install



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