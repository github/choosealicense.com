# frozen_string_literal: true

require 'open-uri'

# SPDX license-list-data plain-text filenames for legacy spdx-id values in _licenses.
SPDX_PLAIN_TEXT_ALIASES = {
  'AGPL-3.0' => 'AGPL-3.0-only',
  'GPL-2.0' => 'GPL-2.0-only',
  'GPL-3.0' => 'GPL-3.0-only',
  'GFDL-1.3' => 'GFDL-1.3-no-invariants-only',
  'LGPL-2.1' => 'LGPL-2.1-only',
  'LGPL-3.0' => 'LGPL-3.0-only'
}.freeze

SPDX_PLAIN_TEXT_BASE = 'https://raw.githubusercontent.com/spdx/license-list-data/master/text'

# Appended translations after this separator are excluded from SPDX comparison.
# See https://github.com/github/choosealicense.com/issues/1126
SPDX_PLAIN_TEXT_TRANSLATION_SEPARATOR = "\n\n----------------------------------------------------------------------\n\n"

# Licenses verified to match SPDX plain text byte-for-byte (see spec/spdx_plain_text_spec.rb).
SPDX_PLAIN_TEXT_MATCHING = %w[
  BlueOak-1.0.0
  CC0-1.0
].freeze

def license_plain_text(path)
  raw = File.read(path)
  parts = raw.split("---\n")
  raise "Missing YAML front matter in #{path}" if parts.length < 3

  parts[2].strip
end

def license_plain_text_for_spdx(path)
  text = license_plain_text(path)
  if text.include?(SPDX_PLAIN_TEXT_TRANSLATION_SEPARATOR)
    text.split(SPDX_PLAIN_TEXT_TRANSLATION_SEPARATOR, 2).first
  else
    text
  end
end

def spdx_plain_text_filename(spdx_id)
  SPDX_PLAIN_TEXT_ALIASES.fetch(spdx_id, spdx_id)
end

def fetch_spdx_plain_text(spdx_id)
  filename = spdx_plain_text_filename(spdx_id)
  url = "#{SPDX_PLAIN_TEXT_BASE}/#{filename}.txt"
  URI.open(url, read_timeout: 15).read.strip
end

def normalize_license_plain_text(text)
  text.gsub("\r\n", "\n").gsub(/[ \t]+\n/, "\n").strip
end
