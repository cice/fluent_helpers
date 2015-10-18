require 'fluent_helpers/themes/bootstrap/btn'
require 'fluent_helpers/themes/bootstrap/table'

module FluentHelpers
  module Themes
    module Bootstrap
      extend ActiveSupport::Concern

      protected
      def table_class
        Table
      end

      def link_class
        Btn
      end
    end
  end
end
