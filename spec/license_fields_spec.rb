require 'spec_helper'

licenses.each do |license|
  describe "The #{license["title"]} license" do
    it "should only contain supported fields" do
      matches = license["content"].scan /\[([a-z]+)\]/
      extra_fields = matches.flatten - fields.map { |f| f["name"] }
      expect(extra_fields).to be_empty
    end
  end
end
