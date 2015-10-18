require 'fluent_helpers/themes/bootstrap/btn'

module FluentHelpers
  module Themes
    module Inspinia
      class Btn < ::FluentHelpers::Themes::Bootstrap::Btn

        # Styles
        %w[white outline block dim circle rounded].each do |name|
          class_alias name, "btn-#{name}"
        end
      end
    end
  end
end
