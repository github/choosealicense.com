require 'jekyll'
require 'open-uri'
require 'json'
require 'open-uri'
require 'nokogiri'

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

def families
  licenses.map { |l| l["family"] }.compact.uniq
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

def spdx_ids
  spdx_list.map { |name, properties| name.downcase }
end

def find_spdx(license)
  spdx_list.find { |name, properties| name.downcase == license }
end

def osi_approved_licenses
  $osi_approved_licenses ||= begin
    licenses = {}
    list = spdx_list.select { |id, meta| meta["osiApproved"] }
    list.each do |id, meta|
      licenses[id.downcase] = meta["name"]
    end
    licenses
  end
end

def fsf_approved_licenses
  $fsf_approved_licenses ||= begin
    url = "https://www.gnu.org/licenses/license-list.en.html"
    doc = Nokogiri::HTML(open(url).read)
    list = doc.css(".green dt")
    licenses = {}
    list.each do |license|
      a = license.css("a").find { |link| !link.text.nil? && !link.text.empty? && link.attr("id") }
      next if a.nil?
      id = a.attr("id").downcase
      name = a.text.strip
      licenses[id] = name
    end

    # FSF approved the Clear BSD, but doesn't use its SPDX ID or Name
    if licenses.keys.include? "clearbsd"
      licenses["bsd-3-clause-clear"] = licenses["clearbsd"]
    end

    licenses
  end
end

def od_approved_licenses
  $od_approved_licenses ||= begin
    url = "http://licenses.opendefinition.org/licenses/groups/od.json"
    data = open(url).read
    data = JSON.parse(data)
    licenses = {}
    data.each do |id, meta|
      licenses[id.downcase] = meta["title"]
    end
    licenses
  end
end

def approved_licenses
  (osi_approved_licenses.keys + fsf_approved_licenses.keys + od_approved_licenses.keys).flatten.uniq.sort
end
