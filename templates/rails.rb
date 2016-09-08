run "rm Gemfile"
run "touch Gemfile"

add_source 'http://rubygems.org'

gem 'rails', '4.2.7'
gem 'pg'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

gem 'active_model_serializers'
gem 'slim-rails'
gem 'simple_form'


gem_group :development do
  gem 'quiet_assets'
end

gem_group :development, :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'annotate'
  gem 'guard-rspec', require: false
  gem 'bullet'
end

gem_group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'database_cleaner'
end

gem_group :production do
  gem 'puma'
  gem 'rails_12factor'
end

run "rm README.rdoc"
run "rm README.md"
run "echo '# #{app_name.titleize}' >> README.md"

run "rm -r test"

run "bundle install"

rake("db:create")

generate("rspec:install")
generate("simple_form:install")
run "bundle exec guard init rspec"
run "gem install html2slim"

run "erb2slim . -d"

run "touch .ruby-version"
append_file ".ruby-version", "2.3.1"

run "git init"
