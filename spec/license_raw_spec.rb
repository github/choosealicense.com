# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/license_plain_text'

# Regression guard for https://github.com/github/choosealicense.com/issues/1176
describe 'plain-text license files at licenses/*.txt' do
  let(:raw_dir) { File.expand_path('../licenses', __dir__) }

  it 'has a generated file for every catalog license' do
    licenses.each do |license|
      path = File.join(raw_dir, "#{license['spdx-lcase']}.txt")
      expect(File).to exist(path), "missing #{path}; run `rake licenses:raw`"
    end
  end

  licenses.each do |license|
    context license['spdx-id'] do
      it 'matches the canonical _licenses body' do
        source = File.join(licenses_path, "#{license['spdx-lcase']}.txt")
        raw = File.join(raw_dir, "#{license['spdx-lcase']}.txt")
        expect(File.read(raw).strip).to eq(LicensePlainText.extract_body(source))
      end
    end
  end
end
