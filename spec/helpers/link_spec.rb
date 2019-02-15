require 'spec_helper'

describe FluentHelpers::Helpers::Link do
  let(:template) { TemplateStub.new.tap { |t|
    t.extend FluentHelpers::Helpers
  } }
  let(:link) { described_class.new template }

  example 'Creating a simple link' do
    html = link.to('http://example.org').named 'Click Here'

    expect(html.to_s).to have_tag('a', with: { href: 'http://example.org' }, text: 'Click Here')
  end

  example 'Using a block for the content' do
    html = link.to('http://example.org') do
      template.concat "Click Here"
    end

    expect(html.to_s).to have_tag('a', with: { href: 'http://example.org' }, text: 'Click Here')
  end

  example 'Setting a title' do
    html = link.to('http://example.org').title('Or Not').named 'Click Here'

    expect(html.to_s).to have_tag('a', with: { href: 'http://example.org', title: 'Or Not' }, text: 'Click Here')
  end

  example 'Adding classes, converting underscores to dashes' do
    html = link.to('http://example.org').classes(:foo, :bar_baz).classes(:lorem).named 'Click Here'

    expect(html.to_s).to have_tag('a.foo.bar-baz.lorem', with: { href: 'http://example.org' }, text: 'Click Here')
  end

  example 'Icon-only link' do
    html = link.iconed(:show_me).to_s

    expect(html).to(have_tag('a', with: { title: '..show_me.' }) { with_tag 'i.show-me' })
  end
end
