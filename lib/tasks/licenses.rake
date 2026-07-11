# frozen_string_literal: true

require 'fileutils'
require_relative '../license_plain_text'

namespace :licenses do
  desc 'Generate plain-text license files at licenses/*.txt for curl-friendly URLs (#1176)'
  task :raw do
    repo_root = File.expand_path('../..', __dir__)
    source_dir = File.join(repo_root, '_licenses')
    out_dir = File.join(repo_root, 'licenses')
    FileUtils.mkdir_p(out_dir)

    Dir.glob(File.join(source_dir, '*.txt')).sort.each do |path|
      body = LicensePlainText.extract_body(path)
      out_path = File.join(out_dir, "#{LicensePlainText.spdx_lcase(path)}.txt")
      File.write(out_path, "#{body}\n")
    end
  end
end
