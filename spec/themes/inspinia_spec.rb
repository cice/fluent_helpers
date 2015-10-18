require 'spec_helper'
require 'fluent_helpers/themes/inspinia'

describe FluentHelpers::Themes::Inspinia do
  include FluentHelpers::Helpers
  include FluentHelpers::Themes::Inspinia

  it 'should set proper link_class' do
    expect(link_class).to be FluentHelpers::Themes::Inspinia::Btn
  end
end
