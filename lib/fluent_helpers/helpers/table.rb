module FluentHelpers
  module Helpers
    class Table < Base
      require 'fluent_helpers/helpers/table/builder'

      def initialize template, collection, block
        super template
        @collection = collection
        on_block block
      end

      def belongs_to *parents, &block
        @parents = parents
        on_block block
      end

      def as name, &block
        @options[:as] = name
        classes name
        on_block block
      end

      def with_ids &block
        @with_ids = true
        on_block block
      end

      def to_s
        tab = Builder.new @template, @options, @parents, &@block

        @_.table @options.except(:as).merge(class: css_class) do
          @_.thead! do
            @_.tr! do
              if tab.with_check?
                @_.th! @_.check_box_tag('check_all'), class: 'check'
              end
              tab.columns.each do |c|
                @_.th! c.head, class: c.css_class
              end
              n_actions = tab.actions.count
              @_.th! '', class: 'actions', colspan: n_actions if n_actions > 0
            end
          end
          @_.tbody! do
            @collection.each do |o|
              tr_attrs = {}
              tr_attrs[:data] = { id: o.id } if @with_ids
              @_.tr! tr_attrs do
                if tab.with_check?
                  @_.td! @_.check_box_tag('ids[]', o.id), class: 'check'
                end
                tab.columns.each do |c|
                  @_.td! c.get(o), class: c.css_class
                end

                tab.actions.each do |a|
                  @_.td! a.get(o).to_s, class: 'action'
                end
              end
            end
          end
        end
      end

      protected
      def default_classes
        ['table']
      end
    end
  end
end
