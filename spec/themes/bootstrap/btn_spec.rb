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
      expect(btn.__send__(style).to_s).to have_tag("a.btn-#{style}")
    end
  end

  it 'should set size classes' do
    sizes = %w[lg sm xs]

    sizes.each do |size|
      expect(btn.__send__(size).to_s).to have_tag("a.btn-#{size}")
    end
  end

  it 'should set state classes' do
    states = %w[active disabled]

    states.each do |state|
      expect(btn.__send__(state).to_s).to have_tag("a.#{state}")
    end
  end

  example 'With btn class' do
    expect(btn.as_btn).to have_tag 'a.btn'
  end

  describe 'Setting options' do
    example 'disabled' do
      html = btn.disabled

      expect(html.to_s).to have_tag('a.disabled')
    end

    example 'active' do
      html = btn.active

      expect(html.to_s).to have_tag('a.active')
    end

    describe 'Conditional options' do
      example 'disabled_if true' do
        html = btn.disabled_if true

        expect(html.to_s).to have_tag('a.disabled')
      end

      example 'disabled_if false' do
        html = btn.disabled_if false

        expect(html.to_s).not_to have_tag('a.disabled')
      end

      example 'active_if true' do
        html = btn.active_if true

        expect(html.to_s).to have_tag('a.active')
      end

      example 'active_if false' do
        html = btn.active_if false

        expect(html.to_s).not_to have_tag('a.active')
      end
    end
  end
end
