require 'fluent_helpers/helpers'

module FluentHelpers
  module Themes
    module Fontawesome
      extend ActiveSupport::Concern

      autoload :Icn, 'fluent_helpers/themes/fontawesome/icn'

      included do
        ::FluentHelpers::Helpers::Icn.send :include, Icn
      end
    end
  end
end
