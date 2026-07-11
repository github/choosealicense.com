# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

describe 'license source metadata' do
  licenses.each do |license|
    context license['spdx-id'] do
      let(:raw) { YAML.safe_load_file("_licenses/#{license['spdx-lcase']}.txt", permitted_classes: [Date, Time], aliases: true) }
      let(:source) { raw['source'] }

      it 'uses SPDX as the canonical reference (source must match spdx.org when set)' do
        next unless source

        spdx_id = license['spdx-id']
        expect(source).to match(%r{\Ahttps://spdx\.org/licenses/#{Regexp.escape(spdx_id)}(?:-or-later|-only)?\.html\z}),
                          'source: should match the SPDX license page when provided'
      end
    end
  end

  it 'documents optional source in meta.yml' do
    expect(meta.map { |m| m['name'] }).to include('source')
  end
end
