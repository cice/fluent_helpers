require 'fluent_helpers/helpers/link'

module FluentHelpers
  module Helpers
    class Switch < Link
      def initialize(template)
        super template
        @params = template.params.except :controller, :action
        as_btn
      end

      def exclude_param(*params, &block)
        @params = @params.except *params
        on_block block
      end

      def for_param(param, false_value = nil, true_value = '1', &block)
        @param = param
        @false_value = false_value
        @true_value = true_value
        @value = @params[@param]
        @checked = @value && @value.to_s == true_value
        on_block block
      end

      def to_s
        options = @classes.any? ? @options.merge(class: css_class) : @options

        @_.div class: 'btn-group' do
          @_.link_to!(_get_url, options) do
            @_.concat @_.icn.for(@checked ? :checked : :unchecked)
            @_.concat ' '
            if @block
              @_.capture! &@block
            else
              @_.concat @name
            end
          end
        end
      end

      protected
      def _get_url
        url_params = if @checked
          if @false_value.blank?
            @params.except @param
          else
            @params.merge @param => @false_value
          end
        else
          @params.merge @param => @true_value
        end
        @template.url_for url_params
      end
    end
  end
end
