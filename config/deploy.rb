# require "bundler/capistrano"

require "./config/capistrano_database"

require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p125'
set :rvm_type, :system

set :application, "Myrlund.no"
set :repository,  "git@github.com:myrlund/myrlund.no.git"
set :scm, :git

set :deploy_to, "/srv/www/myrlund.no/blog"

role :web, "danseku"                          # Your HTTP server, Apache/etc
role :app, "danseku"                          # This may be the same as your `Web` server
role :db,  "danseku", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

set :use_sudo, false
set :ssh_options, {:forward_agent => true}

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Clever assets precompilation
namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} assets:precompile}
      # from = source.next_revision(current_revision)
      # if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
      # else
      #   logger.info "Skipping asset pre-compilation because there were no asset changes"
      # end
    end
  end
end
