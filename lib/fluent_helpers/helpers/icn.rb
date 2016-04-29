module FluentHelpers
  module Helpers
    class Icn < Base
      def to_s
        @_.span '', class: css_class
      end

      def type(type)
        @type = type
        self
      end

      def for(action)
        type map action
      end

      def map(action)
        mapping[action.to_s] || mapping[action.to_sym]
      end

      def mapping
        @mapping ||= ::FluentHelpers::Helpers.config.base['icon_mappings']
      end

      protected
      def css_class
        @type.to_s.gsub "_", "-"
      end
    end
  end
end
