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

  example 'Chaining properties on fields/columns' do
    people = [alice]

    html = described_class.new template, people, ->(t) {
      t[:name, :upcase]
    }

    expect(html.to_s).to have_tag('table', with: { class: 'table' }) do
      with_tag 'thead tr th.name-upcase', text: '.name.upcase.'

      with_tag 'tbody tr td.name-upcase', text: 'ALICE'
    end
  end

  example 'Scoping / naming' do
    people = [alice]

    table = described_class.new template, people, ->(t) {
      t[:name]
    }

    table.as(:employees)

    expect(table.to_s).to have_tag('table', with: { class: 'employees' }) do
      with_tag 'thead tr th.name', text: '.employees.name.'
    end
  end

  example 'Setting data-id attributes on body rows' do
    allow(alice).to receive(:id).and_return 1

    people = [alice]

    table = described_class.new template, people, ->(t) {
      t[:name]
    }

    table.with_ids

    expect(table.to_s).to have_tag('table') do
      with_tag 'tbody tr', with: { 'data-id': 1 }
    end
  end

  example 'Adding a checkbox column' do
    allow(alice).to receive(:id).and_return 1

    people = [alice]

    table = described_class.new template, people, ->(t) {
      t.check
      t[:name]
    }

    expect(table.to_s).to have_tag('table') do
      with_tag 'tbody tr td.check input', with: { type: 'checkbox', value: 1 }
    end
  end

  describe 'Columns' do
    example 'link_to'
    example 'link_to icon_only'
    example 'link_to via'

    example 'named'
    example 'unnamed'

    example 'localized'

    example 'as_samp'

  end

  describe 'Actions' do
    before do
      allow(alice).to receive(:id).and_return 1
    end

    example 'Simple, custom action' do
      people = [alice]

      table = described_class.new template, people, ->(t) {
        t[:name]
        t.action { |p|
          template.concat template.link_to(p.name, "http://example.org/people/#{p.id}")
        }
      }

      expect(table.to_s).to have_tag('table') do
        with_tag 'thead tr th.actions'

        with_tag 'tbody tr td.action a', text: 'Alice'
      end
    end

    example 'Spanned header for multiple actions' do
      people = [alice]

      table = described_class.new template, people, ->(t) {
        t[:name]
        t.action { |p|
          template.concat template.link_to(p.name, "http://example.org/people/#{p.id}")
        }
        t.action { |p|
          template.concat template.link_to(p.name, "http://example.org/people/#{p.id}/edit")
        }
      }

      expect(table.to_s).to have_tag('table') do
        with_tag 'thead tr th.actions', with: { colspan: 2 }
      end
    end

    describe 'Conditional action' do
      before do
        res = double(:res)
        allow(res).to receive(:show).and_return('<a>Alice</a>'.html_safe)
        allow(template).to receive(:res).and_return res
      end

      example 'only_if true' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if(true)
        }

        expect(table.to_s).to have_tag('table') do
          with_tag 'tbody tr td.action a', text: 'Alice'
        end
      end

      example 'only_if false' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if(false)
        }

        expect(table.to_s).to have_tag('table') do
          with_tag 'tbody tr td.action', text: ''
        end
      end

      example 'only_if with Proc returning true' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if ->(p) { p.name == 'Alice' }
        }

        expect(table.to_s).to have_tag('table') do
          with_tag 'tbody tr td.action a', text: 'Alice'
        end
      end

      example 'only_if with Proc returning false' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if ->(p) { p.name == 'Bob' }
        }

        expect(table.to_s).to have_tag('table') do
          with_tag 'tbody tr td.action', text: ''
        end
      end
    end
  end
end
