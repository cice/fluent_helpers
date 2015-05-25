module FluentHelpers
  module Themes
    module Bootstrap::Table
      extend ActiveSupport::Concern

      included do
        class_alias :condensed, "table-condensed"
        class_alias :bordered, "table-bordered"
        class_alias :hover, "table-hover"
        class_alias :white, "table-white"
        class_alias :pointer, "table-pointer"
        class_alias :striped, "table-striped"
      end

      def default &block
        condensed.bordered.hover.pointer &block
      end

      def light &block
        condensed.striped.pointer.hover &block
      end
    end
  end
end

