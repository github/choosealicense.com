require 'spec_helper'

licenses.each do |license|
  describe "The #{license["title"]} license" do
    it "should have a title" do
      expect(license["title"]).to_not be_nil
    end

    it "should have a description" do
      expect(license["description"]).to_not be_nil
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
