source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "bootsnap", ">= 1.4.4", require: false
gem "importmap-rails", ">= 0.3.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.0.alpha2"
gem "redis", "~> 4.0"
gem "stimulus-rails", ">= 0.4.0"
gem "turbo-rails", ">= 0.7.11"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Sass to process CSS
# gem "sassc-rails", "~> 2.1"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "activerecord-postgres_enum",
  github: "noelrappin/activerecord-postgres_enum",
  branch: "master"
gem "after_commit_everywhere"
gem "anyway_config"
gem "awesome_rails_console",
  github: "xunker/awesome_rails_console",
  branch: "pry-0.13.0-compatibility"
gem "dry-transaction"
gem "fast_blank", platform: :mri
gem "finnhub_ruby"
gem "mobility"
gem "money"
gem "nilify_blanks"
gem "strong_migrations"
gem "translate_enum"

group :development, :test do
  gem "debug", ">= 1.0.0", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "factory_trace"
  gem "isolator"
  gem "parallel_tests"
  gem "rspec-rails"
end

group :development do
  gem "brakeman", require: false
  # gem "bullet"
  gem "bundler-audit", require: false
  gem "ordinare", require: false
  gem "ruby_audit", require: false
  gem "standard"
end

group :test do
  gem "simplecov"
  gem "simplecov-console"
  gem "rspec_junit_formatter"
  gem "test-prof"
  gem "webmock"
  gem "zonebie"
  gem "vcr"
end
