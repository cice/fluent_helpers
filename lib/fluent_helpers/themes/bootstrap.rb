module FluentHelpers
  module Themes
    module Bootstrap
      extend ActiveSupport::Concern

      included do
        FluentHelpers::Helpers::Link.send :include, Btn

        FluentHelpers::Helpers::Table.send :include, Table
      end
    end
  end
end
