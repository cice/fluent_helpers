require 'spec_helper'
require 'fluent_helpers/themes/inspinia'
require 'fluent_helpers/themes/bootstrap'

describe FluentHelpers::Helpers::Base do
  let(:template) { TemplateStub.new }

  example 'element with classes' do
    html = described_class.new template
    expect {
      html.classes('css-class')
    }.to change {
      html.instance_eval("@classes")
    }.from([]).to(["css-class"])
  end

  example 'link with id' do
    html = described_class.new template
    expect {
      html.id 'awesomeId'
    }.to change {
      html.instance_eval("@id")
    }.from(nil).to('awesomeId')
  end

  example 'link with data' do
    html = described_class.new template
    expect {
      html.data({ whoop: 'awesomeData' })
    }.to change {
      html.instance_eval("@options")
    }.from({}).to({ 'data-whoop' => 'awesomeData'})
  end

  example 'link with inline style' do
    html = described_class.new template
    expect {
      html.style({ color: '#000' })
    }.to change {
      html.instance_eval("@options")
    }.from({}).to({ style: 'color: #000;' })
  end
end
