require "html/proofer"

task :test do
  sh "bundle exec jekyll build --trace"
  # ignore href="#" for the "Copy to clipboard" button
  HTML::Proofer.new("./_site").run
end
