require 'spec_helper'

describe "byte order marks" do
  Dir["#{licenses_path}/*.html"].each do |file|
    context "the #{File.basename(file, ".html")} license" do
      it "does not begin with a byte order mark" do
        bom = !!(File.open(file).read =~ /\A\xEF\xBB\xBF/)
        msg = "License file begins with a Byte Order Mark. See http://stackoverflow.com/a/1068700."
        expect(bom).to eql(false), msg
      end
    end
  end
end
