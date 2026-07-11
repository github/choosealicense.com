# frozen_string_literal: true

require 'spec_helper'

describe 'license rule annotations' do
  licenses.each do |license|
    next unless license['annotations']

    context license['spdx-id'] do
      it 'maps annotation keys to tags declared on the license' do
        declared = (license['permissions'] + license['conditions'] + license['limitations']).uniq
        extra = license['annotations'].keys - declared
        expect(extra).to be_empty, "unknown annotation tags: #{extra.join(', ')}"
      end

      it 'references text that appears in the license body' do
        body = license['content']
        license['annotations'].each_value do |excerpts|
          excerpts.each do |excerpt|
            expect(body).to include(excerpt), "excerpt not found: #{excerpt[0, 60]}..."
          end
        end
      end
    end
  end
end
