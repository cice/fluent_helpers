require 'spec_helper'
require 'fluent_helpers/themes/inspinia'
require 'fluent_helpers/themes/bootstrap'

describe FluentHelpers::Helpers::Table do
  let(:person) { Struct.new :name, :birthday, :country }
  let(:alice) { person.new 'Alice', DateTime.new(1980, 1, 1), 'US' }
  let(:bob) { person.new 'Bob', DateTime.new(1981, 1, 1), 'UK' }
  let(:template) { TemplateStub.new.tap { |t|
    t.extend FluentHelpers::Helpers
  } }

  example 'A simple table with 2 columns' do
    people = [alice, bob]

    html = described_class.new template, people, ->(t) {
      t[:name]
      t[:country]
    }

    expect(html.to_s).to have_tag('table') do
      with_tag 'thead tr th.name', text: '.name.'
      with_tag 'thead tr th.country', text: '.country.'

      with_tag 'tbody tr td.name', text: 'Alice'
      with_tag 'tbody tr td.name', text: 'Bob'

      with_tag 'tbody tr td.country', text: 'US'
      with_tag 'tbody tr td.country', text: 'UK'
    end
  end

  example 'bootstrap table with default style' do
    people = [alice]

    table = FluentHelpers::Themes::Bootstrap::Table.new template, people, -> (t) {
      t[:name]
    }

    table.default
    expect(table.to_s).to have_tag('table', with: { class: ["table", "table-condensed", "table-bordered", "table-hover", "table-pointer"] })
  end

  example 'bootstrap table with light style' do
    people = [alice]

    table = FluentHelpers::Themes::Bootstrap::Table.new template, people, -> (t) {
      t[:name]
    }

    table.light
    expect(table.to_s).to have_tag('table', with: { class: ["table", "table-condensed", "table-striped", "table-hover", "table-pointer"] })
  end

  example 'Chaining properties on fields/columns' do
    people = [alice]

    html = described_class.new template, people, ->(t) {
      t[:name, :upcase]
    }

    expect(html.to_s).to have_tag('table') do
      with_tag 'thead tr th.name-upcase', text: '.name.upcase.'

      with_tag 'tbody tr td.name-upcase', text: 'ALICE'
    end
  end

  example 'parents' do
    admin_parent = double(:admin_parent)
    allow(template).to receive(:url_for)

    people = [alice]
    table = described_class.new template, people, -> (t) {
      t.action(:show)
    }

    table.belongs_to(admin_parent)
    expect(table.to_s).to have_tag('table')
    expect(template).to have_received(:url_for).with([admin_parent, alice])
  end

  example 'Scoping / naming' do
    people = [alice]

    table = described_class.new template, people, ->(t) {
      t[:name]
    }

    table.as(:employees)

    expect(table.to_s).to(have_tag('table', with: { class: 'employees' }) { with_tag 'thead tr th.name', text: '.employees.name.' })
  end

  example 'Setting data-id attributes on body rows' do
    allow(alice).to receive(:id).and_return 1

    people = [alice]

    table = described_class.new template, people, ->(t) {
      t[:name]
    }

    table.with_ids

    expect(table.to_s).to(have_tag('table') { with_tag 'tbody tr', with: { 'data-id' => 1 } })
  end

  example 'Adding a checkbox column' do
    allow(alice).to receive(:id).and_return 1

    people = [alice]

    table = described_class.new template, people, ->(t) {
      t.check
      t[:name]
    }

    expect(table.to_s).to(have_tag('table') { with_tag 'tbody tr td.check input', with: { type: 'checkbox', value: 1 } })
  end

  describe 'Columns' do
    before do
      allow(alice).to receive(:url).and_return 'http://google.de'
    end

    example 'link_to' do
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].link_to :url
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag 'td a i'
        with_tag('td a', with: { href: 'http://google.de' })
      })
    end

    example 'link_to icon_only' do
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].link_to(:url).icon_only
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag('td a', with: { href: 'http://google.de' })
        with_tag 'td a i.show'
      })
    end

    example 'link_to via' do
      mock_root = double(:mock_root)
      allow(mock_root).to receive(:url_for).and_return '/awesomepath/'
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].link_to(:url).via mock_root
      }

      expect(table.to_s).to(have_tag('table') { with_tag 'td a', with: { href: '/awesomepath/' } })
      expect(mock_root).to have_received(:url_for)
    end

    example 'named' do
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].named(:whoop)
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag('thead tr th')
        with_tag('tbody tr td')
      })
    end

    example 'unnamed' do
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].unnamed
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag('thead tr th')
        with_tag('tbody tr td')
      })
    end

    example 'localized' do
      allow(template).to receive(:localize).and_return('Alice.long')
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].localized(:long)
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag 'tbody tr td'
      })
      expect(template).to have_received(:localize).with('Alice', { format: :long })
    end

    example 'as_samp' do
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].as_samp
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag('tbody tr td samp')
      })
    end

    example 'align_right' do
      people = [alice]

      table = described_class.new template, people, -> (t) {
        t[:name].align_right
      }

      expect(table.to_s).to(have_tag('table') {
        with_tag('tbody tr td.text-right')
      })
    end
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

      expect(table.to_s).to(have_tag('table') {
        with_tag 'thead tr th.actions'

        with_tag 'tbody tr td.action a', text: 'Alice'
      })
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

      expect(table.to_s).to(have_tag('table') { with_tag 'thead tr th.actions', with: { colspan: 2 } })
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

        expect(table.to_s).to(have_tag('table') { with_tag 'tbody tr td.action a', text: 'Alice' })
      end

      example 'only_if false' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if(false)
        }

        expect(table.to_s).to(have_tag('table') { with_tag 'tbody tr td.action', text: '' })
      end

      example 'only_if with Proc returning true' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if ->(p) { p.name == 'Alice' }
        }

        expect(table.to_s).to(have_tag('table') { with_tag 'tbody tr td.action a', text: 'Alice' })
      end

      example 'only_if with Proc returning false' do
        people = [alice]

        table = described_class.new template, people, ->(t) {
          t[:name]
          t.action(:show).only_if ->(p) { p.name == 'Bob' }
        }

        expect(table.to_s).to(have_tag('table') { with_tag 'tbody tr td.action', text: '' })
      end
    end
  end
end
