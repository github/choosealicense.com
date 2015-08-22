require 'spec_helper'

licenses.each do |license|

  # Manually load the raw license so we don't get thed defaults
  raw_fields = SafeYAML.load_file("_licenses/#{license["id"]}.txt")

  describe "The #{license["title"]} license" do
    it "should only contain supported meta fields" do
      extra_fields = raw_fields.keys - meta.map { |m| m["name"] }
      expect(extra_fields).to be_empty
    end

    it "should contain all required meta fields" do
      required = meta.select { |m| m["required"] }.map { |m| m["name"] }
      missing = required - raw_fields.keys
      expect(missing).to be_empty
    end

    if license["category"]
      it "should contain the required license variant fields" do
        missing = ["category", "tab-slug"] - license.keys
        expect(missing).to be_empty
      end
    else
      it "should not contain license family specific fields" do
        extra = ["variant", "category", "tab-slug"].select{ |f| raw_fields.keys.include?(f) }
        expect(extra).to be_empty
      end
    end
  end
end
