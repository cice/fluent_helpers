require 'spec_helper'
require 'fluent_helpers/themes/fontawesome'

describe FluentHelpers::Themes::Fontawesome do
  include FluentHelpers::Helpers
  include FluentHelpers::Themes::Fontawesome

  it 'should set proper icn_class' do
    expect(icn_class).to be FluentHelpers::Themes::Fontawesome::Icn
  end
end
