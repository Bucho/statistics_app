set :application, "statistics.hashtrain.com"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "rails_app"
set :deploy_to, "/home/rails_app/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
#set :scm_passphrase, "1831224" This is your custom users password

set :repository, "git@github.com:Bucho/statistics_app.git"
set :branch, "master"

namespace :deploy do

  desc "Copy production database configuration"
  task :after_symlink, :roles => [:app, :db, :web] do
    #copy config
    run "cp #{current_path}/config/deploy/database.yml #{current_path}/config/database.yml"
  end      

  desc "Restart Passenger" 
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt" 
  end

end

after 'deploy:update_code', 'deploy:symlink_shared'


#
#set :application, "rubyflow"
#set :repository,  "http://svn.assembla.com/svn/rubyflowru"
#
## If you aren't deploying to /u/apps/#{application} on the target
## servers (which is the default), you can specify the actual location
## via the :deploy_to variable:
#set :deploy_to, "/home/rails_app/#{application}"
## If you aren't using Subversion to manage your source code, specify
## your SCM below:
## set :scm, :subversion
##set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yaml"
#set :scm_username, 'shaliko' 
#set :scm_password, '1831224'
#
#set :user, 'rails_app'
#set :password, ''
#set :use_sudo, false
#set :keep_releases, 3
#
#role :app, "72.14.187.82"
#role :web, "72.14.187.82"
#role :db,  "72.14.187.82", :primary => true
#
#after   'deploy:update',  :run_after_update_commands
##before  'deploy:cold',    :stop_mongrel
#
#task :run_after_update_commands, :roles => :web do
#  #run "cd #{current_path} && chmod 755 script/process/reaper"
#  #run "cd #{current_path} && chmod 755 script/spin"
#  #run "cd #{current_path} && chmod -R 777 tmp/pids"
#  #run "cp #{current_path}/config/deploy/database.yml #{current_path}/config/database.yml"
#  run "touch #{current_path}/tmp/restart.txt"
#  run "chmod 777 #{current_path}/tmp/restart.txt"
#end
#
#task :stop_mongrel, :roles => :web do
#  #run "cd #{current_path} && mongrel_rails cluster::stop"
#end
#
#desc "Make spin script executable"
#task :make_spin_script_executable, :roles => :app do
#  #run "cd #{current_path} && chmod 755 script/spin"
#  #
#end
##before "deploy:start", "make_spin_script_executable"