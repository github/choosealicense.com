# frozen_string_literal: true

require 'spec_helper'

describe 'word wrapping' do
  Dir["#{licenses_path}/*.txt"].each do |file|
    context "the #{File.basename(file, '.txt')} license" do
      it 'does not wrap at line length 78' do
        file_content = File.read(file, encoding: 'utf-8')
        license_text = file_content.match(/\A(?:---\n.*\n---\n+)?(.*)/m)[1]
        max_line_length = 0
        max_line = ""
        license_text.lines.each do |line|
          line.chomp!
          if line.length > max_line_length
            max_line_length = line.length
            max_line = line
          end
        end
        msg = "Longest line is #{max_line_length} characters: #{max_line}"
        skip msg if max_line_length > 78 && max_line_length < 81
        expect(max_line_length).to be <= 78, msg
      end
    end
  end
end
