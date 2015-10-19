require 'spec_helper'
require 'fluent_helpers/themes/inspinia'
require 'fluent_helpers/themes/bootstrap'

describe FluentHelpers::Helpers::Base do
  let(:person) { Struct.new :name, :birthday, :country }
  let(:template) { TemplateStub.new.tap { |t|
    t.extend FluentHelpers::Helpers
  } }

  before do
    allow(template).to receive(:url_for).and_return('/awesome/')
  end

  example 'link with classes' do
    html = FluentHelpers::Helpers::Link.new template, ->(b) { }
    html.classes 'css-class'
    expect(html.to_s).to have_tag('a.css-class')
  end

  example 'link with id' do
    html = FluentHelpers::Helpers::Link.new template, ->(b) { }
    html.classes 'awesomeId'
    expect(html.to_s).to have_tag('a.awesomeId')
  end

  example 'link with data' do
    html = FluentHelpers::Helpers::Link.new template, ->(b) { }
    html.data({ whoop: 'awesomeData' })
    expect(html.to_s).to have_tag('a', with: { 'data-whoop': 'awesomeData' })
  end

  example 'link with inline style' do
    html = FluentHelpers::Helpers::Link.new template, ->(b) { }
    html.style({ color: '#000' })
    expect(html.to_s).to have_tag('a')
    expect(html.to_s).to match /style="color: #000;"/
  end



end
