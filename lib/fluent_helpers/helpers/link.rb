module FluentHelpers
  module Helpers
    class Link < Base
      def initialize template, url_opts = '#'
        super template
        @url_opts = url_opts
      end

      def to *url_opts, &block
        if url_opts.length == 1
          url_opts = url_opts.first
        end
        @url_opts = url_opts

        on_block block
      end

      def iconed icon, &block
        icn = @template.icn.for icon
        title_string = @template.t ".#{icon}"

        title title_string
        named icn
        on_block block
      end

      def named name, &block
        @name = name
        on_block block
      end

      def to_s
        options = @classes.any? ? @options.merge(class: css_class) : @options
        if @block
          @template.link_to @url_opts, options, &@block
        else
          @template.link_to @name, @url_opts, options
        end
      end
    end
  end
end
