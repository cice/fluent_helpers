module FluentHelpers
  module Helpers
    class Icn < Base
      def to_s
        @_.span '', class: css_class
      end

      def type type
        @type = type
        self
      end

      def for action
        type map action
      end

      def map action
        mapping[action.to_sym]
      end

      def mapping
        @mapping ||= ::Hash.new do |h, k|
          h[k.to_sym] = k.to_sym
        end
      end

      protected
      def css_class
        @type.to_s.gsub "_", "-"
      end
    end
  end
end
