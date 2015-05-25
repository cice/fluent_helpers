module FluentHelpers
  module Themes
    module Inspinia::Btn
      extend ActiveSupport::Concern

      included do
        # Styles
        %w[white outline block dim circle rounded].each do |name|
          class_alias name, "btn-#{name}"
        end
      end
    end
  end
end
