# frozen_string_literal: true

require 'spec_helper'

describe 'license fillable fields' do
  licenses.each do |license|
    context "The #{license['title']} license" do
      matches = license['content'].scan(/(\A|\W)\[([a-z]+)\]/).map { |row| row[1] }
      extra_fields = matches.flatten - (fields.map { |f| f['name'] })
      it 'should only contain supported fillable fields' do
        expect(extra_fields).to be_empty
      end
      it 'does not overlook supported fillable fields' do
        matches_generous = license['content'].scan(/\[([a-z]+)\]/)
        extra_fields_generous = matches_generous.flatten - (fields.map { |f| f['name'] })
        expect(matches_generous.flatten - extra_fields_generous).to eq matches
      end
    end
  end
end
