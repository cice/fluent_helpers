module FluentHelpers
  module Helpers
    class Table < Base
      require 'fluent_helpers/helpers/table/builder'
      require 'fluent_helpers/helpers/table/default_decoration'

      def initialize(template, collection, block, decoration = nil)
        @decoration = decoration || DefaultDecoration
        @collection = collection
        super template, block
      end

      def belongs_to(*parents, &block)
        @parents = parents
        on_block block
      end

      def as(name, &block)
        @options[:as] = name
        classes name
        on_block block
      end

      def with_ids(&block)
        @with_ids = true
        on_block block
      end

      def to_s
        tab = Builder.new @template, @options, @parents, &@block

        @_.table @options.except(:as).merge(class: css_class) do
          build_thead tab
          build_tbody tab
        end
      end

      protected
      def build_tbody(tab)
        @_.tbody! do
          @collection.each do |o|
            build_tbody_tr tab, o
          end
        end
      end

      def build_tbody_tr(tab, o)
        tr_attrs = {}
        tr_attrs[:data] = { @decoration.row_data_id_name => o.id } if @with_ids
        @_.tr! tr_attrs do
          build_tbody_check tab, o
          build_tbody_columns tab, o
          build_tbody_actions tab, o
        end
      end

      def build_tbody_check(tab, o)
        if tab.with_check?
          @_.td! @_.check_box_tag(@decoration.check_name, o.id), class: @decoration.check_class
        end
      end

      def build_tbody_actions(tab, o)
        tab.actions.each do |a|
          @_.td! a.get(o).to_s, class: @decoration.action_class
        end
      end

      def build_tbody_columns(tab, o)
        tab.columns.each do |c|
          @_.td! c.get(o), class: c.css_class
        end
      end

      def build_thead(tab)
        @_.thead! do
          @_.tr! do
            build_thead_check tab
            build_thead_columns tab
            build_thead_actions tab
          end
        end
      end

      def build_thead_actions(tab)
        n_actions = tab.actions.count
        @_.th! '', class: @decoration.actions_class, colspan: n_actions if n_actions > 0
      end

      def build_thead_columns(tab)
        tab.columns.each do |c|
          @_.th! c.head, class: c.css_class
        end
      end

      def build_thead_check(tab)
        if tab.with_check?
          @_.th! @_.check_box_tag(@decoration.check_all_name), class: @decoration.check_class
        end
      end

      def default_classes
        @decoration.default_classes
      end
    end
  end
end
