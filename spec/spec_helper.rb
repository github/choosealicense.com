require 'jekyll'
require 'open-uri'
require 'json'

def config_file
  File.expand_path "./_config.yml", source
end

def source
  File.expand_path("../", File.dirname(__FILE__))
end

def config
  config = Jekyll::Configuration.new.read_config_file config_file
  config = Jekyll::Utils.deep_merge_hashes(config, {:source => source})
  Jekyll::Utils.deep_merge_hashes(Jekyll::Configuration::DEFAULTS, config)
end

def licenses
  site.collections["licenses"].docs.map { |l| l.to_liquid.merge("id" => l.basename(".txt")) }
end

def categories
  licenses.map { |l| l["category"] }.compact.uniq
end

def site
  $site ||= begin
    site = Jekyll::Site.new(config)
    site.reset
    site.read
    site
  end
end

def rules
  site.data["rules"]
end

def fields
  site.data["fields"]
end

def meta
  site.data["meta"]
end

def rule?(tag, group)
  rules[group].any? { |r| r["tag"] == tag }
end

def spdx_list
  url = "https://raw.githubusercontent.com/sindresorhus/spdx-license-list/master/spdx.json"
  $spdx ||= JSON.parse(open(url).read)
end

def find_spdx(license)
  spdx_list.find { |name, properties| name.downcase == license }
end
