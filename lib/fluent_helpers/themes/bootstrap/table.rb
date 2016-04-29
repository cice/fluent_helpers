module FluentHelpers
  module Themes
    module Bootstrap
      class Table < ::FluentHelpers::Helpers::Table

        class_alias :condensed, "table-condensed"
        class_alias :bordered, "table-bordered"
        class_alias :hover, "table-hover"
        class_alias :white, "table-white"
        class_alias :pointer, "table-pointer"
        class_alias :striped, "table-striped"

        def default(&block)
          condensed.bordered.hover.pointer &block
        end

        def light(&block)
          condensed.striped.pointer.hover &block
        end

        def default_classes
          ['table']
        end
      end
    end
  end
end
