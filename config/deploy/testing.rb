require 'uri'

namespace :deploy do
  set :application, "taskboard"

  # If you aren't deploying to /u/apps/#{application} on the target
  # servers (which is the default), you can specify the actual location
  # via the :deploy_to variable:
  set :deploy_to, "/var/www/rails/#{application}/testing"

  set :scm, :git
  set :repository,  "git@github.com:mlainez/#{application}.git"
  set :branch, "develop"
  set :use_sudo, false
  set :user, 'deploy'

  server "dev.agilar.org", :app, :web, :db, :primary => true

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
   run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Migrating database (reset)"
  task :rake_db_migrate do
    run "cd #{current_path}/ && rake RAILS_ENV=\"testing\" db:migrate:reset --trace"
  end

  desc "Removng pictures"
  task :remove_pictures do
    run "cd #{current_path}/ && rm -rf public/system/*"
  end

  task :symlink_members_pictures do
    run "ln -s #{deploy_to}/shared/system/ #{deploy_to}/current/public/system"
  end

  desc "Seeding Database"
  task :rake_db_seed do
    run "cd #{current_path}/ && rake RAILS_ENV=\"testing\" db:seed --trace"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

  after "deploy:update", "deploy:rake_db_migrate", "deploy:remove_pictures", "symlink_members_pictures", "deploy:rake_db_seed"
end