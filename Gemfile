source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '4.1.4'
gem 'rails', '4.2.5'

# Use postgres as the database for Active Record
gem 'pg'

gem 'bootstrap-sass'
gem 'bcrypt'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'rspec-rails'
  # The following optional lines are part of the advanced setup.
#  gem 'guard-rspec'
#  gem 'spork-rails'
#  gem 'guard-spork'
  #gem 'childprocess'
end

# Use specific version of nokogiri - install of 1.6.2.1 failed
#gem 'nokogiri', '1.6.1'
gem 'nokogiri'

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  # Uncomment these lines on Linux
  gem 'libnotify'
end

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

# Use debugger
#gem 'debugger', group: [:development, :test]

# For CSV or Excel import/export
gem 'roo'
