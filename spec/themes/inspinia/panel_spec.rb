require 'spec_helper'
require 'fluent_helpers/themes/inspinia'

describe FluentHelpers::Themes::Inspinia::Panel do
  include FluentHelpers::Helpers

  let(:template) { TemplateStub.new }
  let(:panel) { FluentHelpers::Themes::Inspinia::Panel.new(template) }

  example 'A complete example' do
    html = panel.named('foo') do
      template.concat 'bar'
    end.to_s

    expect(html).to have_tag('div.panel.panel-default') do
      with_tag 'div.panel-heading', text: 'foo'
      with_tag 'div.panel-body', text: 'bar'
    end
  end

  example 'With different styles' do
    styles = %w[default info warning danger success primary]

    styles.each do |style|
      html = panel.__send__(style).named('foo') do
        template.concat 'bar'
      end.to_s

      expect(html).to have_tag("div.panel.panel-#{style}")
    end
  end

  example 'Without heading' do
    html = panel.default do
      template.concat 'bar'
    end.to_s

    expect(html).to have_tag('div.panel.panel-default') do
      without_tag 'div.panel-heading'
      with_tag 'div.panel-body', text: 'bar'
    end
  end
end
