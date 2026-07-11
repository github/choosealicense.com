# frozen_string_literal: true

require 'html-proofer'
require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--order', 'rand', '--color']
end

task :test do
  sh 'bundle exec jekyll build'
  Rake::Task['spec'].invoke
  HTMLProofer.check_directory('./_site',
                              check_html: true,
                              enforce_https: true,
                              validation: { ignore_script_embeds: true },
                              url_swap: { %r{https://choosealicense.com} => '' },
                              url_ignore: [%r{https://github.com/github/choosealicense.com/edit/gh-pages/_licenses/},
                                           %r{https://help.github.com},
                                           %r{https://opensource.org}],
                              hydra: { max_concurrency: 10 },
                              check_img_http: true).run
end

task :approved_licenses do
  require './spec/spec_helper'
  approved = approved_licenses
  approved.select! { |l| spdx_ids.include?(l) }
  puts "#{approved.count} approved licenses:"
  puts approved.join(', ')
  puts "\n"

  potential = approved - licenses.map { |l| l['id'] }
  puts "#{potential.count} potential additions:"
  puts potential.join(', ')
end

namespace :licenses do
  desc 'Report licenses whose optional source: does not match SPDX canonical URLs'
  task :source_report do
    require 'yaml'
    Dir['_licenses/*.txt'].each do |path|
      raw = YAML.safe_load_file(path, permitted_classes: [Date, Time], aliases: true)
      next unless raw['source']

      spdx = raw['spdx-id']
      expected = %r{\Ahttps://spdx\.org/licenses/#{Regexp.escape(spdx)}(?:-or-later|-only)?\.html\z}
      puts "Mismatch: #{path} -> #{raw['source']}" unless raw['source'].match?(expected)
    end
  end
end
