require 'spec_helper'

describe "license categories" do
  families.each do |family|
    context "the #{family} family" do
      family_licenses = licenses.select { |l| l["family"] == family }
      primary = family_licenses.select  { |l| l["variant"] == false }
      variants = family_licenses.select { |l| l["variant"] == true }

      it "should only have one primary license" do
        expect(primary.count).to eql(1)
      end

      it "all other licenses should be variants" do
        expected = family_licenses.count - 1
        expect(variants.count).to eql(expected)
      end

      family_licenses.each do |license|
        context "the #{license["title"]} license" do
          it "should have a unique slug" do
            dupes = family_licenses.select { |l| l["tab-slug"] == license["tab-slug"] }.count
            expect(dupes).to eql(1)
          end

          it "should have a valid tab-slug" do
            expect(license["tab-slug"]).to match(/[a-z0-9_]/)
          end
        end
      end
    end
  end
end
