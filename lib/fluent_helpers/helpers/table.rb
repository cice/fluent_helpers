module FluentHelpers
  module Helpers
    class Table < Base
      class Column < ::FluentHelpers::Helpers::Base
        def initialize template, keys, options, block
          super template
          @keys = keys
          @options = options
          on_block block

          classes @keys.join('_')
        end

        def _get_value obj
          @keys.inject(obj) { |o, k| o.try k }
        end

        def named name, &block
          @name = name
          on_block block
        end

        def translated attribute, dl
          @block = ::Proc.new do |obj|
            @_.concat obj.translator.get(attribute, dl.id)
          end
          named dl.name
        end

        def localized format = :short
          @block = ::Proc.new do |obj|
            val = _get_value obj
            if val.present?
              @_.concat @_.localize(val, format: format)
            end
          end
        end

        def unnamed &block
          @name = ''
          on_block block
        end

        def as_samp
          @block = ::Proc.new do |obj|
            @_.concat @_.content_tag(:samp, _get_value(obj))
          end
          self
        end

        def head
          @name || @_.translate(i18n_key)
        end

        def get obj
          if @link_to_keys.present?
            content = _get_value obj
            obj = @link_to_keys.inject(obj) { |o, k| o.send k }

            return content if obj.blank?

            path = @route_base ? @route_base.url_for(obj) : @_.url_for(obj)
            @_.link.to(path).title(content) do
              @_.concat @_.icn.for :show
              if !@icon_only
                @_.concat " "
                @_.concat content
              end
            end
          elsif @block
            @template.capture do
              @block.call obj
            end
          else
            _get_value obj
          end
        end

        def link_to *keys
          @link_to_keys = keys
          self
        end

        def icon_only
          @icon_only = true
          self
        end

        def align_right &block
          classes 'text-right'
          on_block block
        end

        def via route_base, &block
          @route_base = route_base
          on_block block
        end

        def i18n_key
          @i18n_key ||= begin
            key = @keys.join('.')
            key = "#{@options[:as]}.#{key}" if @options[:as]
            key
          end
        end
      end

      class Action < ::FluentHelpers::Helpers::Base
        def initialize template, action, options, parents
          super template
          @action = action
          @options = options
          @parents = parents
        end

        def only_if condition, &block
          @only_if = condition
          on_block block
        end

        def get obj
          case @action
          when ::Proc
            @template.capture do
              @action.call obj
            end
          else
            if @only_if
              only_if = @only_if.is_a?(::Proc) ? @only_if.call(obj) : @only_if
              return unless only_if
            end
            obj = @parents ? [*@parents, obj] : [obj]
            @template.res(*obj).__send__ @action
          end
        end
      end

      class TableBuilder
        attr_reader :columns, :actions

        def initialize template, options, parents, &block
          @options = options
          @columns = []
          @actions = []
          @parents = parents
          @template = template
          block.call self
        end

        def [] *keys
          col *keys
        end

        def col *keys, &block
          column = Column.new(@template, keys, @options.dup, block)
          @columns << column
          column
        end

        def translated attribute, dl
          col(attribute).translated attribute, dl
        end

        def action action = nil, &block
          action = Action.new(@template, action || block, @options, @parents)
          @actions << action
          action
        end

        def check
          @with_check = true
          nil
        end

        def with_check?
          !!@with_check
        end
      end

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
        tab = TableBuilder.new @template, @options, @parents, &@block

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
