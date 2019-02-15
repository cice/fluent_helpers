require 'spec_helper'
require 'fluent_helpers/themes/inspinia'

describe FluentHelpers::Themes::Inspinia::Ibox do
  include FluentHelpers::Helpers

  let(:template) { TemplateStub.new.tap { |t|
    t.extend FluentHelpers::Themes::Inspinia
  } }
  let(:ibox) { FluentHelpers::Themes::Inspinia::Ibox.new(template) }

  example 'A complete example' do
    html = ibox.named('foo').collapseable do
      template.concat 'bar'
    end.to_s

    expect(html).to have_tag('div#ibox-foo.ibox.float-e-margins') do
      with_tag 'div.ibox-title h5', text: 'foo'
      with_tag 'div.ibox-title div.ibox-tools a.collapse-link i.fa.fa-chevron-up'
      with_tag 'div.ibox-content', text: 'bar'
    end
  end

  example 'Collapsed ibox' do
    html = ibox.named('foo').collapseable(true) do
      template.concat 'bar'
    end.to_s

    expect(html).to have_tag('div#ibox-foo.ibox.float-e-margins') do
      with_tag 'div.ibox-title h5', text: 'foo'
      with_tag 'div.ibox-title div.ibox-tools a.collapse-link i.fa.fa-chevron-down'
      with_tag 'div.ibox-content', text: 'bar', with: { style: 'display: none;' }
    end
  end

  example 'Partial rendering' do
    template.add_partial :foobar, '<h1>FooBar</h1>'

    html = ibox.named('foo').render(:foobar).to_s

    expect(html).to have_tag('div#ibox-foo.ibox.float-e-margins') do
      with_tag 'div.ibox-title h5', text: 'foo'
      with_tag 'div.ibox-content h1', text: 'FooBar'
    end
  end
end
