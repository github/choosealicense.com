require 'spec_helper'

# List of licenses that need not be OSI approved
LICENSE_WHITELIST = %w[
  unlicense
  cc0-1.0
  wtfpl
]

licenses.each do |license|
  describe "The #{license["title"]} license" do
    describe "SPDX compliance" do
      # "No license" isn't really a license, so no need to test
      unless license["id"] == "no-license"
        it "#{license["id"]} should be a valid SPDX ID" do
          expect(find_spdx(license["id"])).to_not be_nil
        end

        it "should be the proper SPDX name" do
          spdx = find_spdx(license["id"])
          expect(spdx[1]["name"].gsub(/ only$/,"")).to eql(license["title"])
        end

        # CC0 and Unlicense are not OSI approved, but that's okay
        unless LICENSE_WHITELIST.include? license["id"]
          it "should be OSI approved" do
            spdx = find_spdx(license["id"])
            approved = spdx[1]["osiApproved"]
            expect(approved).to eql(true)
          end
        end
      end
    end
  end
end
