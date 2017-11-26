# frozen_string_literal: true

require 'licensee'
require 'spec_helper'

describe 'license meta' do
  licenses.each do |license|
    # Manually load the raw license so we don't get the defaults
    raw_fields = SafeYAML.load_file("_licenses/#{license['spdx-lcase']}.txt")

    context "The #{license['title']} license" do
      it 'should only contain supported meta fields' do
        extra_fields = raw_fields.keys - (meta.map { |m| m['name'] })
        expect(extra_fields).to be_empty
      end

      it 'should contain all required meta fields' do
        required = meta.select { |m| m['required'] }.map { |m| m['name'] }
        missing = required - raw_fields.keys
        expect(missing).to be_empty
      end

      examples = raw_fields['using'] || []

      it 'using contains 3 examples' do
        legacy = [
          'afl-3.0',
          'agpl-3.0',
          'artistic-2.0',
          'bsd-2-clause',
          'bsd-3-clause',
          'bsd-3-clause-clear',
          'bsl-1.0',
          'cc0-1.0',
          'cc-by-4.0',
          'cc-by-sa-4.0',
          'eupl-1.1',
          'lgpl-2.1',
          'lgpl-3.0',
          'lppl-1.3c',
          'ms-pl',
          'ms-rl',
          'ofl-1.1',
          'wtfpl',
          'zlib'
        ]
        skip 'added before 3 using examples required' if legacy.include?(license['slug'])
        expect(examples.length).to eq(3)
      end

      context 'licensee detects using examples' do
        module Licensee
          class License
            class << self
              def license_dir
                dir = ::File.dirname(__FILE__)
                ::File.expand_path '../_licenses', dir
              end
            end
          end
        end

        examples.each do |example|
          example_url = example.values[0]
          if example_url.index('https://github.com/') == 0
            example_url.gsub!(%r{\Ahttps://github.com/([\w-]+/[\w-]+)/blob/([\w-]+/\S+)\z}, 'https://raw.githubusercontent.com/\1/\2')
          elsif example_url.index('https://git.savannah.gnu.org/') == 0 || example_url.index('https://git.gnome.org/') == 0
            example_url.gsub!(%r{/tree/}, '/plain/')
          elsif example_url.index('https://bitbucket.org/') == 0
            example_url.gsub!(%r{/src/}, '/raw/')
          end
          content = open(example_url).read
          detected = Licensee::ProjectFiles::LicenseFile.new(content, 'LICENSE').license
          it example_url do
            expect(detected.key).to eq(license['slug'])
          end
        end
      end
    end
  end
end
