module FluentHelpers
  module Themes
    module Inspinia
      extend ActiveSupport::Concern

      included do
        FluentHelpers::Helpers::Link.send :include, Btn
      end

      def ibox &block
        with_using Ibox.new(self, block)
      end

      def panel &block
        with_using Panel.new(self, block)
      end
    end
  end
end
