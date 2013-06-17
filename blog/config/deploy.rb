default_run_options[:shell] = '/bin/bash --login'
set :default_environment, {
  'PATH' => "/opt/rbenv/shims/ruby:$HOME/.rbenv/bin:$PATH"
}
require "bundler/capistrano"

server "192.168.33.20", :web, :app, :db, primary: true

set :application, "blog"
set :user, "deployer"
set :deploy_dir, "/var/www/nginx-default"
set :deploy_to, "#{deploy_dir}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@bitbucket.org:trietle/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start restart].each do |command|
    desc "#{command} passenger server"
    task command, roles: :app, except: {no_release: true} do
      run "touch #{current_path}/tmp/restart.txt"
    end
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Grant permissions to deploy dir"
  task :grant, :roles => :app do
    run "sudo usermod -a -G www-data #{user}"
    run "sudo chown -R #{user}:www-data #{deploy_dir}"
  end

  task :setup_config, roles: :app do
    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    #sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.deploy.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  before "deploy:setup", "deploy:grant"
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
