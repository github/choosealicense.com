require 'spec_helper'

describe "shown licenses" do

  # Whitelist of popular licenses that are shown (non-hidden)
  # Note: most new licenses that are added should be hidden by default
  SHOWN_LICENSES = %w[
    agpl-3.0
    apache-2.0
    artistic-2.0
    bsd-2-clause
    bsd-3-clause
    cc0-1.0
    epl-1.0
    gpl-2.0
    gpl-3.0
    isc
    lgpl-2.1
    lgpl-3.0
    mit
    mpl-2.0
    unlicense
  ]

  it "has the expected number of shown licenses" do
    expect(shown_licenses.count).to eql(15)
  end

  shown_licenses.each do |license|
    context "the #{license["title"]} license" do
      it "is whitelisted to be shown" do
        expect(SHOWN_LICENSES).to include(license["id"])
      end
    end
  end
end
