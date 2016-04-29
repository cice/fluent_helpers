module FluentHelpers
  module Helpers
    class Table::Action < ::FluentHelpers::Helpers::Base
      def initialize(template, action, options, parents)
        super template
        @action = action
        @options = options
        @parents = parents
      end

      def only_if(condition, &block)
        @only_if = condition
        on_block block
      end

      def get(obj)
        case @action
        when ::Proc
          @template.capture do
            @action.call obj
          end
        else
          if !@only_if.nil?
            only_if = @only_if.is_a?(::Proc) ? @only_if.call(obj) : @only_if
            return unless only_if
          end
          obj = @parents ? [*@parents, obj] : [obj]
          @template.res(*obj).__send__ @action
        end
      end
    end
  end
end
