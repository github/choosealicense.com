# frozen_string_literal: true

require 'spec_helper'
require 'json'

describe 'FSF API export' do
  let(:api_path) { File.expand_path '../api/licenses.json', __dir__ }
  let(:payload) { JSON.parse(File.read(api_path)) }

  it 'uses the FSF API context' do
    expect(payload['@context']).to eq('https://wking.github.io/fsf-api/schema/licenses.jsonld')
  end

  it 'includes every catalog license' do
    expect(payload['licenses'].keys.sort).to eq(licenses.map { |l| l['spdx-lcase'] }.sort)
  end

  licenses.each do |license|
    it "exports #{license['spdx-id']} with spdx identifiers and tags" do
      entry = payload['licenses'][license['spdx-lcase']]
      expect(entry['name']).to eq(license['title'])
      expect(entry.dig('identifiers', 'spdx')).to include(license['spdx-id'])
      expect(entry['tags']).to be_a(Array)
      expect(entry['tags']).to include(*license['permissions'])
    end
  end
end
