module FluentHelpers
  module Themes
    module Fontawesome
      class Icn < ::FluentHelpers::Helpers::Icn
        def css_class
          "fa fa-#{super}"
        end
      end
    end
  end
end
