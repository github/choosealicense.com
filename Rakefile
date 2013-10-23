require "html/proofer"

task :test do
  sh "bundle exec jekyll build"
  # ignore href="#" for the "Copy to clipboard" button
  HTML::Proofer.new("./_site", :href_ignore => ["#"]).run
end
