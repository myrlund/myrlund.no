################################################################################
# Much thanks to http://ryanflorence.com/deploying-with-capistrano-without-rails/
################################################################################


# replace these with your server's information
set :domain,  "myrlund.no"
set :user,    "jonas"

# name this the same thing as the directory on your server
set :application, "blog"


# Location of the repository that will be deployed
set :repository, "git@github.com:myrlund/myrlund.no.git"

server "#{domain}", :app, :web, :db, :primary => true

set :deploy_via, :copy
set :copy_exclude, [".git", ".DS_Store"]
set :scm, :git
set :branch, "master"
# set this path to be correct on yoru server
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false
set :keep_releases, 2
#set :git_shallow_clone, 1

# Uncomment the following section if your server uses RVM
# ######################################################
# #                RVM Configurations                  #
# ######################################################
# Add RVM's lib directory to the load path.
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# Load RVM's capistrano plugin.
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p125'
set :rvm_type, :system  # Comment out if using system wide RVM
# ######################################################
# #               End RVM Configurations               #
# ######################################################
#ssh_options[:paranoid] = false

# Run bundle install on remote server
require "bundler/capistrano"

# Symlink database config
require "./config/capistrano_database"

# Run bundler without development and production gems
set :bundle_without,  [:development, :test]
set :bundle_flags, ""

# after 'deploy:update_code' do
#   run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
# end

# Color capistrano output for readability
require "capistrano_colors"
