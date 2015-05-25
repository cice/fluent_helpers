require 'spec_helper'

describe FluentHelpers::Helpers::Link do
  let(:template) { TemplateStub.new }
  let(:link) { described_class.new template }

  example 'Creating a simple link' do
    html = link.to('http://example.org').named 'Click Here'

    expect(html.to_s).to eq %[<a href="http://example.org">Click Here</a>]
  end

  example 'Using a block for the content' do
    html = link.to('http://example.org') do
      template.concat "Click Here"
    end

    expect(html.to_s).to eq %[<a href="http://example.org">Click Here</a>]
  end

  example 'Setting a title' do
    html = link.to('http://example.org').title('Or Not').named 'Click Here'

    expect(html.to_s).to eq %[<a title="Or Not" href="http://example.org">Click Here</a>]
  end

  example 'Adding classes, converting underscores to dashes' do
    html = link.to('http://example.org').classes(:foo, :bar_baz).classes(:lorem).named 'Click Here'

    expect(html.to_s).to eq %[<a class="foo bar-baz lorem" href="http://example.org">Click Here</a>]
  end

  describe 'Setting options' do
    example 'disabled' do
      html = link.to('http://example.org').disabled.named 'Click Here'

      expect(html.to_s).to eq %[<a disabled="disabled" href="http://example.org">Click Here</a>]
    end

    example 'active' do
      html = link.to('http://example.org').active.named 'Click Here'

      expect(html.to_s).to eq %[<a active="true" href="http://example.org">Click Here</a>]
    end

    describe 'Conditional options' do
      example 'disabled_if true' do
        html = link.to('http://example.org').disabled_if(true).named 'Click Here'

        expect(html.to_s).to eq %[<a disabled="disabled" href="http://example.org">Click Here</a>]
      end

      example 'disabled_if false' do
        html = link.to('http://example.org').disabled_if(false).named 'Click Here'

        expect(html.to_s).to eq %[<a href="http://example.org">Click Here</a>]
      end

      example 'active_if true' do
        html = link.to('http://example.org').active_if(true).named 'Click Here'

        expect(html.to_s).to eq %[<a active="true" href="http://example.org">Click Here</a>]
      end

      example 'active_if false' do
        html = link.to('http://example.org').active_if(false).named 'Click Here'

        expect(html.to_s).to eq %[<a href="http://example.org">Click Here</a>]
      end
    end
  end
end
