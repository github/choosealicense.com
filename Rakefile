require "html/proofer"
require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ["--order", "rand", "--color"]
end

task :test do
  sh "bundle exec jekyll build --trace"
  HTML::Proofer.new("./_site").run
  Rake::Task["spec"].invoke
end
