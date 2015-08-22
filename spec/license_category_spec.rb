require 'spec_helper'

categories.each do |category|
  describe "the #{category} category" do
    category_licenses = licenses.select { |l| l["category"] == category }
    primary = category_licenses.select  { |l| l["variant"] == false }
    variants = category_licenses.select { |l| l["variant"] == true }

    it "should only have one primary license" do
      expect(primary.count).to eql(1)
    end

    it "all other licenses should be variants" do
      expected = category_licenses.count - 1
      expect(variants.count).to eql(expected)
    end

    category_licenses.each do |license|
      describe "the #{license["title"]} license" do
        it "should have a unique slug" do
          dupes = category_licenses.select { |l| l["tab-slug"] == license["tab-slug"] }.count
          expect(dupes).to eql(1)
        end

        it "should have a valid tab-slug" do
          expect(license["tab-slug"]).to match(/[a-z0-9_]/)
        end
      end
    end
  end
end
