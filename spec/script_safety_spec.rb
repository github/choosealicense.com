# frozen_string_literal: true

require 'spec_helper'

describe 'inline script data' do
  let(:safe_json_filter) { %q(| jsonify | replace: '<', '\u003c') }

  it 'escapes less-than characters in all JSON template values' do
    %w[breadcrumbs footer].each do |include_name|
      source = File.read(File.expand_path("../_includes/#{include_name}.html", __dir__))
      expect(source.scan('jsonify').count).to eql(source.scan(safe_json_filter).count)
    end

    template = Liquid::Template.parse(%q({{ value | jsonify | replace: '<', '\u003c' }}))
    Liquid::Template.register_filter(Jekyll::Filters)
    payload = '</script><!--'
    rendered = template.render('value' => payload)

    expect(rendered).to_not include('<')
    expect(JSON.parse(rendered)).to eql(payload)
  end

  it 'protects external links that open in a new tab' do
    source = File.read(File.expand_path('../_includes/sidebar.html', __dir__))

    expect(source).to include('target="_blank" rel="noopener noreferrer"')
  end
end
