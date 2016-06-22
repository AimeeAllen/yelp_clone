source 'https://rubygems.org'
ruby '2.1.2'

gem 'bootstrap-sass', '3.1.1.1'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'spring'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
  gem 'fabrication'
  gem 'faker'
end

group :test do
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'vcr', '2.9.3'
  gem 'capybara'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
