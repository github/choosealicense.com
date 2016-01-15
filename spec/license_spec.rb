require 'spec_helper'

licenses.each do |license|

  # "No license" isn't really a license, so no need to test
  next if license["id"] == "no-license"

  describe "The #{license["title"]} license" do

    let(:id) { license["id"]  }

    it "has an SPDX ID" do
      expect(spdx_ids).to include(id)
    end

    it "uses its SPDX name" do
      spdx = find_spdx(id)
      expect(spdx[1]["name"].gsub(/ only$/,"")).to eql(license["title"])
    end

    context "industry approval" do

      # FSF approved the clear BSD, but doesn't use it's SPDX ID or Name
      if license["id"] == "bsd-3-clause-clear"
        let(:id) { "clearbsd" }
      end

      it "should be approved by OSI or FSF or OD" do
        expect(approved_licenses).to include(id), "See https://git.io/vzCTV."
      end
    end
  end
end
