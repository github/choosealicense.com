require 'spec_helper'

licenses.each do |license|
  describe "The #{license["title"]} license" do
    it "should have a title" do
      expect(license["title"]).to_not be_nil
    end

    it "should have a description" do
      expect(license["description"]).to_not be_nil
    end

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
        unless license["id"] == "unlicense" || license["id"] == "cc0-1.0"
          it "should be OSI approved" do
            spdx = find_spdx(license["id"])
            expect(spdx[1]["osiApproved"]).to eql(true)
          end
        end
      end
    end

    ["permitted", "required", "forbidden"].each do |group|
      describe "#{group} properties" do
        it "should list the properties" do
          expect(license[group]).to_not be_nil
        end

        license[group].to_a.each do |tag|
          describe "#{tag} tag" do
            it "should be a valid tag" do
              expect(rule?(tag,group)).to be(true)
            end
          end
        end
      end
    end
  end
end
