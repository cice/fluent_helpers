require 'spec_helper'

describe FluentHelpers::Helpers::Table do
  let(:person) { Struct.new :name, :birthday, :country }
  let(:alice) { person.new 'Alice', DateTime.new(1980, 1, 1), 'US' }
  let(:bob) { person.new 'Bob', DateTime.new(1981, 1, 1), 'UK' }
  let(:template) { TemplateStub.new }

  example 'A simple table with 2 columns' do
    people = [alice, bob]

    html = described_class.new template, people, ->(t) {
      t[:name]
      t[:country]
    }

    expect(html.to_s).to have_tag('table', with: { class: 'table' }) do
      with_tag 'thead tr th.name', text: '.name.'
      with_tag 'thead tr th.country', text: '.country.'

      with_tag 'tbody tr td.name', text: 'Alice'
      with_tag 'tbody tr td.name', text: 'Bob'

      with_tag 'tbody tr td.country', text: 'US'
      with_tag 'tbody tr td.country', text: 'UK'
    end
  end
end
