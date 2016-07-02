require 'spec_helper'

describe 'shown licenses' do
  # Whitelist of popular licenses that are shown (non-hidden)
  # Note: most new licenses that are added should be hidden by default
  SHOWN_LICENSES = %w(
    agpl-3.0
    apache-2.0
    gpl-3.0
    lgpl-3.0
    mit
    mpl-2.0
    unlicense
  ).freeze

  it 'has the expected number of shown licenses' do
    expect(shown_licenses.count).to eql(7)
  end

  shown_licenses.each do |license|
    context "the #{license['title']} license" do
      it 'is whitelisted to be shown' do
        expect(SHOWN_LICENSES).to include(license['spdx-lcase'])
      end
    end
  end
end
