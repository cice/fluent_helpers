require 'fluent_helpers/themes/inspinia/btn'
require 'fluent_helpers/themes/inspinia/ibox'
require 'fluent_helpers/themes/inspinia/panel'

module FluentHelpers
  module Themes
    module Inspinia
      def ibox &block
        respecting_using Ibox.new(self, block)
      end

      def panel &block
        respecting_using Panel.new(self, block)
      end

      protected
      def link_class
        FluentHelpers::Themes::Inspinia::Btn
      end
    end
  end
end
