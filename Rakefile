require "html/proofer"
require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ["--order", "rand", "--color"]
end

task :test do
  sh "bundle exec jekyll build --trace"
  # ignore href="#" for the "Copy to clipboard" button
  HTML::Proofer.new("./_site").run
end
