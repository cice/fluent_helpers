require 'fluent_helpers/helpers'
require 'fluent_helpers/themes/fontawesome/icn'

module FluentHelpers
  module Themes
    module Fontawesome
      extend ActiveSupport::Concern

      def icn_class
        ::FluentHelpers::Themes::Fontawesome::Icn
      end
    end
  end
end
