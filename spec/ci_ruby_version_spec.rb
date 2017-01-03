require 'json'
require 'open-uri'
require 'spec_helper'
require 'yaml'

describe 'ci ruby version' do
  pages_versions = JSON.parse(open('https://pages.github.com/versions.json').read)
  pages_ruby_version = pages_versions['ruby']

  ci_config_file = '.travis.yml'

  ci_config = YAML.load_file(ci_config_file)
  ci_ruby_version = ci_config['rvm'][0]

  context "#{ci_config_file} and pages ruby versions" do
    it 'do not match' do
      msg = "(#{ci_ruby_version}) != (#{pages_ruby_version})"
      expect(ci_ruby_version).to eql(pages_ruby_version), msg
    end
  end
end
