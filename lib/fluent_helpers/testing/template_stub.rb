require 'action_view/helpers'

module FluentHelpers
  module Testing
    class TemplateStub
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::FormTagHelper

      attr_accessor :output_buffer

      def initialize
        @output_buffer = ""
        @partials = {}
      end

      def concat obj
        @output_buffer += obj.to_s
      end

      def to_s
        @output_buffer
      end

      def translate *keys
        '.' + keys.map(&:to_s).join('.') + '.'
      end
      alias_method :t, :translate

      def add_partial name, content
        @partials[name.to_sym] = content.html_safe
      end

      def capture_partial name, &block
        add_partial name, capture(&block)
      end

      def render name
        @partials[name.to_sym] || raise(ActionView::MissingTemplate)
      end

      def localize val, format: :short
        "#{val}.#{format}"
      end
    end
  end
end
