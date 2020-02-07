source 'https://rubygems.org'

ruby '2.6.1'

gem 'rails', '~> 6.0.0.rc1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'pry-rails'
gem 'pry-byebug'
gem 'dotenv-rails'
gem 'curb', '0.9.7'

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.5'
  gem 'webmock'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :production do
  gem 'rails_12factor'
end
