require 'spec_helper'
require 'fluent_helpers/themes/fontawesome'

describe FluentHelpers::Themes::Fontawesome::Icn do
  include FluentHelpers::Helpers
  include FluentHelpers::Themes::Fontawesome

  let(:template) { TemplateStub.new }
  let(:icn) { FluentHelpers::Helpers::Icn.new(template) }

  it 'should render a span tag with appropriate classes set' do
    expect(icn.type :download).to have_tag(:span, with: { class: 'fa fa-download' })
  end

  it 'should normalize types (replace underscore with dash etc)' do
    expect(icn.type :download_file).to have_tag(:span, with: { class: 'fa fa-download-file' })
  end

  it 'should use an identity mapping for non existent mappings' do
    expect(icn.for :download).to have_tag(:span, with: { class: 'fa fa-download-file' })
  end

  it 'should support mappings' do
    icn.mapping[:get_that_file] = :download

    expect(icn.for :get_that_file).to have_tag(:span, with: { class: 'fa fa-download-file' })
  end
end
