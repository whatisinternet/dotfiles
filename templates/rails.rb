run "rm Gemfile"
run "touch Gemfile"

add_source 'https://rubygems.org' do

  gem 'rails', '5.0.0.1'
  gem 'pg'

  gem 'sass-rails'
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'jquery-rails'
  gem "autoprefixer-rails"

  gem 'delayed_job_active_record'
  gem 'active_model_serializers'
  gem 'slim-rails'
  gem 'simple_form'


  gem_group :development, :test do
    gem 'awesome_print'
    gem 'dotenv-rails'
    gem 'pry'
    gem 'pry-rails'
    gem 'annotate'
    gem 'guard-rspec', require: false
    gem 'bullet'
    gem 'rack-mini-profiler', require: false
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
  end
end

run "rm README.rdoc"
run "rm README.md"
run "echo '# #{app_name.titleize}' >> README.md"

run "rm -r test"

run "bundle install"

rake("db:create")

generate("rspec:install")
run "bundle binstubs rspec-core"

generate("simple_form:install")

run "bundle exec guard init rspec"
run "gem install html2slim"

run "erb2slim . -d"

run "touch .ruby-version"
append_file ".ruby-version", "2.3.1"

run "git init"
