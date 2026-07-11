# frozen_string_literal: true

module LicensePlainText
  module_function

  def extract_body(path)
    raw = File.read(path)
    parts = raw.split("---\n")
    raise "Missing YAML front matter in #{path}" if parts.length < 3

    body = parts[2].strip
    # Bilingual files: SPDX English before translation separator (see #1126).
    separator = "\n\n----------------------------------------------------------------------\n\n"
    body = body.split(separator, 2).first if body.include?(separator)
    body
  end

  def spdx_lcase(path)
    File.basename(path, '.txt')
  end
end
