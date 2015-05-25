module FluentHelpers
  module Themes
    module Inspinia
      extend ActiveSupport::Concern

      included do
        FluentHelpers::Helpers::Link.send :include, Btn
      end

      def ibox &block
        Ibox.new self, block
      end

      def panel &block
        Panel.new self, block
      end
    end
  end
end
