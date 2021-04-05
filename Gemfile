# frozen_string_literal: true

source 'https://rubygems.org'

require 'json'
require 'net/http'
versions = JSON.parse(Net::HTTP.get(URI('https://pages.github.com/versions.json')))

gem 'github-pages', versions['github-pages']

group :development do
  gem 'colored'
  gem 'fuzzy_match'
  gem 'terminal-table'
end

group :test do
  gem 'html-proofer', '~> 3.0'
  gem 'licensee', git: 'https://github.com/licensee/licensee.git', branch: 'master'
  gem 'rake'
  gem 'rspec'
  gem 'rubocop'
end
