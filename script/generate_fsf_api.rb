#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates api/licenses.json in FSF License Metadata API compatible form.
# Usage: script/generate_fsf_api.rb

require 'json'
require 'yaml'
require 'open-uri'

FSF_URL = 'https://wking.github.io/fsf-api/licenses-full.json'
CONTEXT = 'https://wking.github.io/fsf-api/schema/licenses.jsonld'

def fsf_by_spdx
  object = JSON.parse(OpenURI.open_uri(FSF_URL).read)
  map = {}
  object['licenses'].each do |fsf_id, meta|
    next unless meta.dig('identifiers', 'spdx')

    meta['identifiers']['spdx'].each do |spdx|
      map[spdx.downcase] ||= { 'fsf_id' => fsf_id, 'meta' => meta }
    end
  end
  map
end

fsf_map = fsf_by_spdx
licenses = {}

Dir['_licenses/*.txt'].sort.each do |path|
  slug = File.basename(path, '.txt')
  parts = File.read(path).split(/^---$/, 3)
  meta = YAML.safe_load(parts[1], permitted_classes: [Date, Time], aliases: true)
  spdx_id = meta['spdx-id']
  fsf = fsf_map[spdx_id.downcase]

  tags = []
  tags.concat(meta['permissions'] || [])
  tags.concat(meta['conditions'] || [])
  tags.concat(meta['limitations'] || [])
  tags << 'libre' if fsf && fsf['meta']['tags']&.include?('libre')
  tags.uniq!

  entry = {
    'name' => meta['title'],
    'identifiers' => { 'spdx' => [spdx_id] },
    'tags' => tags
  }
  if fsf
    entry['identifiers']['FSF'] = [fsf['fsf_id']]
    entry['uris'] = fsf['meta']['uris'] if fsf['meta']['uris']
  end
  licenses[slug] = entry
end

payload = { '@context' => CONTEXT, 'licenses' => licenses }
File.write('api/licenses.json', JSON.pretty_generate(payload))
