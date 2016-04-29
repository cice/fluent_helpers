require 'fluent_helpers/themes/bootstrap/btn'
require 'fluent_helpers/themes/bootstrap/table'

module FluentHelpers
  module Themes
    module Bootstrap
      extend ActiveSupport::Concern

      autoload :DropdownSwitch,     'fluent_helpers/themes/bootstrap/dropdown_switch'
      autoload :TextSearch,         'fluent_helpers/themes/bootstrap/text_search'
      autoload :Badge,              'fluent_helpers/themes/bootstrap/badge'

      def dropdown_switch
        respecting_using DropdownSwitch.new(self)
      end

      def badge
        Badge.new(self)
      end

      def switch
        super.classes(:btn_white)
      end

      def text_search
        respecting_using TextSearch.new(self)
      end

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
