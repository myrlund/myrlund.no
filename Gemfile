source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'mysql2', group: :production

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  
  gem 'anjlab-bootstrap-rails', require: 'bootstrap-rails',
                                git: 'https://github.com/anjlab/bootstrap-rails.git'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Auth
gem 'devise'
gem 'cancan'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'

# Object extensions
gem 'stringex'

# Markup
gem 'coderay'
gem 'pygments.rb'
gem 'redcarpet'
gem 'haml-rails'
gem 'simple_form'

# Testing and spec'ing
group :test do
  gem 'rspec'
  gem 'guard-rspec'
  gem 'rb-fsevent', require: false
end

# Deployment
gem 'capistrano'
gem 'yaml_db'
