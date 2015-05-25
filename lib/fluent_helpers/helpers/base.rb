module FluentHelpers
  module Helpers
    class Base < ActiveSupport::ProxyObject
      def initialize template, block = nil
        @options = {}
        @block = nil
        @template = template
        @classes = default_classes

        @_ = Generator.new @template

        on_block block
      end

      def classes *classes, &block
        @classes += classes
        on_block block
        self
      end

      def data kv, &block
        on_block block
        kv.each do |k, v|
          k = 'data-' + k.to_s.gsub('_', '-')
          @options[k] = v
        end
        self
      end

      def style styles, &block
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

      protected
      def css_class
        @classes.compact.map { |c| c.to_s.gsub("_", "-") }.uniq
      end

      def default_classes
        []
      end

      def method_missing name, *args, &block
        @options[name.to_sym] = args.any? ? args.first : true
        on_block block
        self
      end

      def on_block block
        @block = block if block
        self
      end

      class << self
        def class_alias name, klass = nil
          klass ||= name
          class_eval <<-RUBY
            def #{name} &block
              on_block block
              @classes << '#{klass.to_s}'
              self
            end
          RUBY
        end
      end
    end
  end
end
