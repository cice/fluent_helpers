module FluentHelpers
  module Helpers
    class Table::Column < ::FluentHelpers::Helpers::Base
      def initialize(template, keys, options, block)
        super template
        @keys = keys
        @options = options
        on_block block

        classes @keys.join('_')
      end

      def _get_value(obj)
        @keys.inject(obj) { |o, k| o.try k }
      end

      def named(name, &block)
        @name = name
        on_block block
      end

      def localized(format = :short)
        @block = ::Proc.new do |obj|
          val = _get_value obj
          if val.present?
            @_.concat @_.localize(val, format: format)
          end
        end
      end

      def unnamed(&block)
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

      def get(obj)
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

      def link_to(*keys)
        @link_to_keys = keys
        self
      end

      def icon_only
        @icon_only = true
        self
      end

      def align_right(&block)
        classes 'text-right'
        on_block block
      end

      def align_center(&block)
        classes 'text-center'
        on_block block
      end

      def via(route_base, &block)
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
  end
end
