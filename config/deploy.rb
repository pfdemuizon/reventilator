set :application, "reventilator"
set :repository,  "git@github.com:pfdemuizon/#{application}.git"

set :user, "revent"
set :group, "#{user}"

set :deploy_to "/home/#{user}/#{application}"
set :scm, :git
set :keep_releases, 8


role :app, "slicehost.radicaldesigns.org"
role :web, "slicehost.radicaldesigns.org"
role :db, "slicehost.radicaldesigns.org", :primary => true

set :deploy_via, :remote_cache
set :git_enable_submodules, 1

set :use_sudo, true

namespace :deploy do
  desc "Start reventilator"
  task :start, :roles => :app do
    invoke_command "monit -g #{group} start all"
  end

  desc "Stop reventilator"
  task :stop, :roles => :app do
    invoke_command "monit -g #{group} stop all"
  end

  desc "Restart the server"
  task :restart, :roles => :app do
    invoke_command "monit -g #{group} restart all"
  end

  task :symlink_shared, :roles => :app, :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    invoke_command "ln -nfs #{shared_path}/config/mongrel_cluster.yml #{release_path}/config/database.yml"
  end
end
