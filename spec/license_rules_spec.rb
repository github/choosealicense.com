require 'spec_helper'

licenses.each do |license|

  groups = rules.keys

  describe "The #{license["title"]} license" do
    groups.each do |group|

      valid_tags = rules[group].map { |r| r["tag"] }

      describe "the #{group} group" do
        it "should exist" do
          expect(license[group]).to_not be_nil
        end

        it "should only contain valid tags" do
          extra = license[group] - valid_tags
          expect(extra).to be_empty
        end
      end
    end
  end
end
