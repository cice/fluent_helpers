require 'fluent_helpers/helpers/table/column'
require 'fluent_helpers/helpers/table/action'

module FluentHelpers
  module Helpers
    class Table::Builder
      attr_reader :columns, :actions

      def initialize(template, options, parents, &block)
        @options = options
        @columns = []
        @actions = []
        @parents = parents
        @template = template
        block.call self
      end

      def [](*keys)
        col *keys
      end

      def col(*keys, &block)
        column = Table::Column.new(@template, keys, @options.dup, block)
        @columns << column
        column
      end

      def action(action = nil, &block)
        action = Table::Action.new(@template, action || block, @options, @parents)
        @actions << action
        action
      end

      def check(param = 'ids[]')
        @with_check = param
        nil
      end

      def radio(param = 'id')
        @with_radio = param
        nil
      end

      def with_radio?
        !!@with_radio
      end

      def with_check?
        !!@with_check
      end

      def _check_param
        @with_check
      end

      def _radio_param
        @with_radio
      end
    end
  end
end
