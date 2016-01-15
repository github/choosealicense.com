require 'spec_helper'

licenses.each do |license|

  # "No license" isn't really a license, so no need to test
  next if license["id"] == "no-license"

  describe "The #{license["title"]} license" do

    let(:id) { license["id"] }

    it "has an SPDX ID" do
      expect(spdx_ids).to include(id)
    end

    it "uses its SPDX name" do
      spdx = find_spdx(id)
      expect(spdx[1]["name"].gsub(/ only$/,"")).to eql(license["title"])
    end

    it "should be approved by OSI or FSF or OD" do
      osi = osi_approved?(id)
      fsf = fsf_approved?(id)
      od  = od_approved?(id)

      approved = osi || fsf || od
      msg = "The license must be approved by OSI, FSF, or OD. See https://git.io/vzCTV."
      expect(approved).to eql(true), msg
    end
  end
end
