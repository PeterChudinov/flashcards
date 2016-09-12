source 'https://rubygems.org'

# Ruby
ruby '2.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Figaro for environmental variables
gem 'figaro'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Weird shit going on
gem 'rake', '~> 11.2.2'
# Use UnicodeUtils to work with cyrilic text
gem 'unicode_utils'
# RuboCop I don't even know why
gem 'rubocop', '~> 0.41.1', require: false
# Kaminari for paginating
gem 'kaminari'
# Sorcery for auth
gem "sorcery"
# Simple Form for forms
gem 'simple_form'

# Paperclip and AWS to attach card images
gem "paperclip", "~> 5.0.0"
gem 'aws-sdk'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # RSpec for testing
  gem 'rspec-rails', '~> 3.5.0beta1'
  # FactoryGirl to populate test db
  gem 'factory_girl_rails'
  # Capybara to test user behaviour
  gem 'capybara'
  # Capybara page screenshots
  gem 'capybara-screenshot'
  # Codeclimate button
  gem "codeclimate-test-reporter", require: nil
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

