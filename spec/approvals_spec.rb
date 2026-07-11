# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

describe 'approvals data' do
  let(:approvals_path) { File.expand_path '../_data/approvals.yml', __dir__ }
  let(:approvals) { YAML.safe_load_file(approvals_path, permitted_classes: [Date, Time], aliases: true) }

  it 'has an entry for each catalog license' do
    expect(approvals.keys.sort).to eq(licenses.map { |l| l['spdx-lcase'] }.sort)
  end

  licenses.each do |license|
    context license['spdx-id'] do
      let(:entry) { approvals[license['spdx-lcase']] }

      it 'includes spdx-id and boolean flags' do
        expect(entry['spdx-id']).to eq(license['spdx-id'])
        expect(entry.keys).to contain_exactly('spdx-id', 'osi', 'fsf', 'od')
      end

      it 'matches live OSI/FSF/OD data' do
        slug = license['spdx-lcase']
        expect(entry['osi']).to eq(osi_approved_licenses.key?(slug))
        expect(entry['fsf']).to eq(fsf_approved_licenses.key?(slug))
        expect(entry['od']).to eq(od_approved_licenses.key?(slug))
      end
    end
  end
end
