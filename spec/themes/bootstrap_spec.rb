require 'spec_helper'
require 'fluent_helpers/themes/bootstrap'

describe FluentHelpers::Themes::Bootstrap do
  include FluentHelpers::Helpers
  include FluentHelpers::Themes::Bootstrap

  it 'should set proper table_class' do
    expect(table_class).to be FluentHelpers::Themes::Bootstrap::Table
  end

  it 'should set proper link_class' do
    expect(link_class).to be FluentHelpers::Themes::Bootstrap::Btn
  end
end
