module FluentHelpers
  module Themes
    module Bootstrap
      extend ActiveSupport::Concern

      included do
        FluentHelpers::Helpers::Link.send :include, Btn
      end
    end
  end
end
