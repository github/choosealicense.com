require 'spec_helper'

describe 'license meta' do
  licenses.each do |license|
    # Manually load the raw license so we don't get the defaults
    raw_fields = SafeYAML.load_file("_licenses/#{license['id']}.txt")

    context "The #{license['title']} license" do
      it 'should only contain supported meta fields' do
        extra_fields = raw_fields.keys - meta.map { |m| m['name'] }
        expect(extra_fields).to be_empty
      end

      it 'should contain all required meta fields' do
        required = meta.select { |m| m['required'] }.map { |m| m['name'] }
        missing = required - raw_fields.keys
        expect(missing).to be_empty
      end

      if license['family']
        it 'should contain the required license variant fields' do
          missing = %w(family) - license.keys
          expect(missing).to be_empty
        end
      else
        it 'should not contain license family specific fields' do
          extra = %w(variant family).select { |f| raw_fields.keys.include?(f) }
          expect(extra).to be_empty
        end
      end
    end
  end
end
