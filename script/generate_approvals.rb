#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates _data/approvals.yml from SPDX OSI flags and FSF/OD approval lists.
# Usage: script/generate_approvals.rb

require 'yaml'
require 'json'
require 'open-uri'

def spdx_list
  url = 'https://spdx.org/licenses/licenses.json'
  JSON.parse(OpenURI.open_uri(url).read)['licenses'].to_h { |l| [l['licenseId'], l] }
end

def osi_ids(spdx)
  spdx.select { |_id, meta| meta['isOsiApproved'] }.keys.map(&:downcase).to_h { |id| [id, true] }
end

def fsf_ids
  url = 'https://wking.github.io/fsf-api/licenses-full.json'
  object = JSON.parse(OpenURI.open_uri(url).read)
  ids = {}
  object['licenses'].each_value do |meta|
    next unless meta.dig('identifiers', 'spdx') && meta['tags']&.include?('libre')

    meta['identifiers']['spdx'].each { |identifier| ids[identifier.downcase] = true }
  end
  ids
end

def od_ids
  url = 'https://licenses.opendefinition.org/licenses/groups/od.json'
  data = JSON.parse(OpenURI.open_uri(url).read)
  data.keys.to_h { |id| [id.downcase, true] }
end

spdx = spdx_list
osi = osi_ids(spdx)
fsf = fsf_ids
od = od_ids

approvals = {}
Dir['_licenses/*.txt'].sort.each do |path|
  slug = File.basename(path, '.txt')
  front = File.read(path).split(/^---$/)[1]
  meta = YAML.safe_load(front, permitted_classes: [Date, Time], aliases: true)
  spdx_id = meta['spdx-id']
  key = spdx_id.downcase
  approvals[slug] = {
    'spdx-id' => spdx_id,
    'osi' => !!osi[key],
    'fsf' => !!fsf[key],
    'od' => !!od[key]
  }
end

File.write('_data/approvals.yml', approvals.to_yaml)
