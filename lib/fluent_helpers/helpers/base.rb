module FluentHelpers
  module Helpers
    class Base < ActiveSupport::ProxyObject
      def initialize(template, block = nil)
        @options = {}
        @block = nil
        @template = template
        @classes = default_classes

        @_ = Generator.new @template

        on_block block
      end

      def id(id, &block)
        @id = id
        on_block block
      end

      def classes(*classes, &block)
        @classes += classes
        on_block block
        self
      end

      def data(kv, &block)
        on_block block
        kv.each do |k, v|
          k = 'data-' + k.to_s.gsub('_', '-')
          @options[k] = v
        end
        self
      end

      def style(styles, &block)
        @options[:style] = styles.sum("") do |(k, v)|
          "#{k}: #{v};"
        end
        on_block block
      end

      def to_s
        __class__.name
      end

      def to_str
        to_s
      end

      def to_ary
        nil
      end

      def _hamlout
        nil
      end

      protected
      def _proc_or_accessor(obj, method)
        case method
        when ::Proc
          method.call obj
        when ::Symbol, ::String
          obj.send method
        else
          raise ::ArgumentError.new("Expected a Proc, Symbol or String, got: #{method.class}")
        end
      end

      def css_class
        @classes.compact.map { |c| c.to_s.gsub("_", "-") }.uniq
      end

      def default_classes
        []
      end

      def method_missing(name, *args, &block)
        @options[name.to_sym] = args.any? ? args.first : true
        on_block block
        self
      end

      def on_block(block)
        @block = block if block
        self
      end

      class << self
        def class_alias(name, klass = nil)
          klass ||= name
          class_eval <<-RUBY
            def #{name} &block
              @classes << '#{klass.to_s}'
              on_block block
            end
          RUBY
        end
      end
    end
  end
end
