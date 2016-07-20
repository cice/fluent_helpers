module FluentHelpers
  module Helpers
    class Icn < Base
      def to_s
        @_.i '', class: css_class
      end

      def type(type)
        @type = type
        self
      end

      def for(action)
        type map action
      end

      def map(action)
        icn = mapping[action.to_s] || mapping[action.to_sym]
        case icn
        when ::Hash
          @flip = icn['flip']

          icn['icon']
        when ::String, ::Symbol
          icn
        when nil
          action
        end
      end

      def mapping
        @mapping ||= ::FluentHelpers::Helpers.config.base['icon_mappings']
      end

      protected
      def css_class
        super + [@type.to_s.gsub('_', '-')]
      end
    end
  end
end
