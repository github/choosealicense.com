# frozen_string_literal: true

source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']

group :development do
  gem 'colored'
  gem 'fuzzy_match'
  gem 'terminal-table'
end

group :test do
  gem 'html-proofer', '~> 3.0'
  gem 'nokogiri'
  gem 'rake'
  gem 'rspec'
  gem 'rubocop'
end
