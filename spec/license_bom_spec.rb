require 'spec_helper'

describe "license file" do

  bom = "\xEF\xBB\xBF".each_byte.to_a

  files = Dir["_licenses/*.txt"]

  files.each do |fn|
    first3 = File.open(fn) {|f| f.read(3)}

    it "#{fn} should not have a byte order mark" do
      expect(first3.each_byte.to_a).not_to eq(bom)
    end
  end
end
