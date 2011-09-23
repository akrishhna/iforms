set :application, "iforms"
set :repository,  "git@github.com:apatlola/iforms.git"
set :domain, '173.255.195.108' #Your Accelerators public IP address

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


set :deploy_to, "/home/deployer/iforms/"
set :user, "root"
set :scm_passphrase, "startUP"

role :web, domain     # Your HTTP server, Apache/etc
role :app, domain     # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

 
#after "deploy:symlink"
#, "deploy:update_crontab"  
#namespace :deploy do  
#desc "Update the crontab file"  
#task :update_crontab, :roles => :db do  
#run "cd #{release_path} && whenever --update-crontab #{application}"  
#end  
#end  
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