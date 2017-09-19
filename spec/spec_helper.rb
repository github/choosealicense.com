# frozen_string_literal: true

require 'jekyll'
require 'open-uri'
require 'json'
require 'open-uri'
require 'nokogiri'

module SpecHelper
  class << self
    attr_accessor :config, :licenses, :site, :spdx
    attr_accessor :osi_approved_licenses, :fsf_approved_licenses, :od_approved_licenses
  end
end

def config_file
  File.expand_path './_config.yml', source
end

def source
  File.expand_path('../', File.dirname(__FILE__))
end

def licenses_path
  File.expand_path '_licenses', source
end

def config
  SpecHelper.config ||= begin
    config = Jekyll::Configuration.new.read_config_file config_file
    config = Jekyll::Utils.deep_merge_hashes(config, source: source)
    Jekyll::Utils.deep_merge_hashes(Jekyll::Configuration::DEFAULTS, config)
  end
end

def licenses
  SpecHelper.licenses ||= begin
    site.collections['licenses'].docs.map do |license|
      spdx_lcase = File.basename(license.basename, '.txt')
      license.to_liquid.merge('spdx-lcase' => spdx_lcase)
    end
  end
end

def shown_licenses
  licenses.reject { |l| l['hidden'] }
end

def site
  SpecHelper.site ||= begin
    site = Jekyll::Site.new(config)
    site.reset
    site.read
    site
  end
end

def rules
  site.data['rules']
end

def fields
  site.data['fields']
end

def meta
  site.data['meta']
end

def rule?(tag, group)
  rules[group].any? { |r| r['tag'] == tag }
end

def spdx_list
  url = 'https://raw.githubusercontent.com/sindresorhus/spdx-license-list/master/spdx.json'
  SpecHelper.spdx ||= JSON.parse(open(url).read)
end

def spdx_ids
  spdx_list.map { |name, _properties| name }
end

def find_spdx(license)
  spdx_list.find { |name, _properties| name == license }
end

def osi_approved_licenses
  SpecHelper.osi_approved_licenses ||= begin
    licenses = {}
    list = spdx_list.select { |_id, meta| meta['osiApproved'] }
    list.each do |id, meta|
      licenses[id.downcase] = meta['name']
    end
    licenses
  end
end

def fsf_approved_licenses
  SpecHelper.fsf_approved_licenses ||= begin
    url = 'https://www.gnu.org/licenses/license-list.en.html'
    doc = Nokogiri::HTML(open(url).read)
    list = doc.css('.green dt')
    licenses = {}
    list.each do |license|
      a = license.css('a').find { |link| !link.text.nil? && !link.text.empty? && link.attr('id') }
      next if a.nil?
      id = a.attr('id').downcase
      name = a.text.strip
      licenses[id] = name
    end

    # FSF approved the Clear BSD, but doesn't use its SPDX ID or Name
    if licenses.keys.include? 'clearbsd'
      licenses['bsd-3-clause-clear'] = licenses['clearbsd']
    end

    licenses
  end
end

def od_approved_licenses
  SpecHelper.od_approved_licenses ||= begin
    url = 'http://licenses.opendefinition.org/licenses/groups/od.json'
    data = open(url).read
    data = JSON.parse(data)
    licenses = {}
    data.each do |id, meta|
      licenses[id.downcase] = meta['title']
    end
    licenses
  end
end

def approved_licenses
  (osi_approved_licenses.keys + fsf_approved_licenses.keys + od_approved_licenses.keys).flatten.uniq.sort
end
