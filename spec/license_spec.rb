require 'spec_helper'

describe "licenses" do

  it "matches the number of files in the _licenses folder" do
    expect(licenses.count).to eql(Dir["#{licenses_path}/*.txt"].count)
  end

  licenses.each do |license|

    context "The #{license["title"]} license" do

      let(:id) { license["id"]  }

      it "has an SPDX ID" do
        expect(spdx_ids).to include(id)
      end

      it "uses its SPDX name" do
        spdx = find_spdx(id)
        expect(spdx).to_not be_nil
        expect(spdx[1]["name"].gsub(/ only$/,"")).to eql(license["title"])
      end

      context "industry approval" do
        it "should be approved by OSI or FSF or OD" do
          expect(approved_licenses).to include(id), "See https://git.io/vzCTV."
        end
      end
    end
  end
end
