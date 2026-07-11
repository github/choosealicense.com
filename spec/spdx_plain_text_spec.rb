# frozen_string_literal: true

require 'spec_helper'
require_relative 'support/spdx_plain_text'

# Regression guard for https://github.com/github/choosealicense.com/issues/636
# New catalog entries must match SPDX plain text; legacy mismatches stay pending.
describe 'SPDX plain text license bodies' do
  licenses.each do |license|
    spdx_id = license['spdx-id']
    path = File.join(licenses_path, "#{license['spdx-lcase']}.txt")

    context spdx_id do
      it 'matches the SPDX license-list-data plain text' do
        local = normalize_license_plain_text(license_plain_text(path))
        spdx = normalize_license_plain_text(fetch_spdx_plain_text(spdx_id))

        if SPDX_PLAIN_TEXT_MATCHING.include?(spdx_id)
          expect(local).to eq(spdx)
        else
          pending 'Known mismatch with SPDX plain text; tracked in issue #636' if local != spdx
          expect(local).to eq(spdx)
        end
      end
    end
  end
end
