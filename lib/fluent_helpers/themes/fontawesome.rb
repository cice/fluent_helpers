module FluentHelpers
  module Themes
    module Fontawesome
      extend ActiveSupport::Concern

      included do
        FluentHelpers::Helpers::Icn.send :include, Icn
      end
    end
  end
end
