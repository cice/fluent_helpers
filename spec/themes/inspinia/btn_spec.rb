require 'spec_helper'
require 'fluent_helpers/themes/inspinia'

describe FluentHelpers::Themes::Inspinia::Btn do
  include FluentHelpers::Helpers

  let(:template) { TemplateStub.new }
  let(:btn) { FluentHelpers::Themes::Inspinia::Btn.new(template) }

  it 'should render a link' do
    expect(btn.to_s).to have_tag 'a'
  end

  it 'should set style classes' do
    styles = %w[white outline block dim circle rounded]

    styles.each do |style|
      expect(btn.__send__(style).to_s).to have_tag('a', with: { class: "btn-#{style}" })
    end
  end

  it 'should mix with bootstrap styles' do
    expect(btn.rounded.primary).to have_tag('a', with: { class: "btn-rounded btn-primary" })
  end
end
