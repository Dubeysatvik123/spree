# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.2"

# Core Rails
gem "rails", "~> 8.1"
gem "puma", "~> 7.2"
gem "bootsnap", require: false

# Database
gem "mysql2", "~> 0.5"
gem "devise"
# Assets
gem "sprockets-rails"
gem "image_processing", "~> 1.13"
gem "mini_magick"

# Background jobs (required by Spree)
gem "sidekiq"

# Redis (used by Sidekiq)
gem "redis", ">= 4.0"

# Logging (production improvement)
gem "lograge"

# Spree (Stable Release)
gem "spree", "~> 5.3"
gem "spree_emails", "~> 5.3"
gem "spree_sample", "~> 5.3"
gem "spree_storefront", "~> 5.3"
gem "spree_admin", "~> 5.3"
gem "spree_i18n"

# Security & performance
gem "rack-cors"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "web-console"

  # Capistrano Deployment
  gem "capistrano", "~> 3.18", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem "capistrano-rbenv", "~> 2.2", require: false
  gem "capistrano-bundler", "~> 2.1", require: false
  gem "capistrano3-puma", require: false
end

group :production do
  gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
end
