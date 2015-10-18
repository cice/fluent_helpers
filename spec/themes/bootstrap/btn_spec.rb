require 'spec_helper'
require 'fluent_helpers/themes/bootstrap'

describe FluentHelpers::Themes::Bootstrap::Btn do
  include FluentHelpers::Helpers

  let(:template) { TemplateStub.new }
  let(:btn) { FluentHelpers::Themes::Bootstrap::Btn.new(template) }

  it 'should render a link' do
    expect(btn.to_s).to have_tag 'a'
  end

  it 'should set style classes' do
    styles = %w[default primary success info warning danger link]

    styles.each do |style|
      expect(btn.__send__(style).to_s).to have_tag('a', with: { class: "btn-#{style}" })
    end
  end

  it 'should set size classes' do
    sizes = %w[lg sm xs]

    sizes.each do |size|
      expect(btn.__send__(size).to_s).to have_tag('a', with: { class: "btn-#{size}" })
    end
  end

  it 'should set state classes' do
    states = %w[active disabled]

    states.each do |state|
      expect(btn.__send__(state).to_s).to have_tag('a', with: { class: state })
    end
  end
end
