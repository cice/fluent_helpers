require 'spec_helper'

describe FluentHelpers::Helpers::Generator do
  let(:template) { double :template }
  let(:generator) { described_class.new template }

  describe 'Tag Methods' do
    it 'should delegate tag methods to template#content_tag' do
      expect(template).to receive(:content_tag).with(:div, 'Hello', class: 'foobar')

      generator.div 'Hello', class: 'foobar'
    end

    it 'should delegate tag! methods to template#content_tag and append via template#concat' do
      expect(template).to receive(:content_tag).with(:div, 'Hello', class: 'foobar').and_return("<div>Hello</div>")
      expect(template).to receive(:concat).with("<div>Hello</div>")

      generator.div! 'Hello', class: 'foobar'
    end
  end

  describe 'Helper methods' do
    it 'should delegate all other methods to template' do
      expect(template).to receive(:link_to).with('Click Here', 'http://example.org').and_return("<a href='http://example.org'>Click Here</a>")

      generator.link_to 'Click Here', 'http://example.org'
    end
  end

  describe 'Lazy method augmentation' do
    it 's helper methods should get augmented lazily upon first call' do
      expect(described_class.instance_methods).not_to include :translate

      allow(template).to receive(:translate)
      generator.translate 'foo.bar'
      expect(described_class.instance_methods).to include :translate
    end
  end
end
