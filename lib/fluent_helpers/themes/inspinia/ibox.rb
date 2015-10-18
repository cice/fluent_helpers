module FluentHelpers
  module Themes
    class Inspinia::Ibox < FluentHelpers::Helpers::Base

      def to_s
        id = @name.present? ? 'ibox-' + @name.parameterize : nil
        @_.div @options.merge(class: css_class, id: id) do
          build_title
          build_content
        end
      end

      def _get_collapse_icn
        @collapsed ? 'fa fa-chevron-down' : 'fa fa-chevron-up'
      end

      def _get_content_style
        @collapsed ? 'display: none;' : ''
      end

      def named name, &block
        @name = name
        on_block block if block
        self
      end

      def collapseable collapsed = false, &block
        @collapseable = true
        @collapsed = collapsed
        on_block block
      end

      def render *args
        @block = ::Proc.new do
          @_.render!(*args)
        end
        self
      end

      protected
      def build_content
        @_.div! class: 'ibox-content', style: _get_content_style, &@block
      end

      def build_title
        if @name
          @_.div! class: 'ibox-title' do
            @_.h5! @name

            build_tools
          end
        end
      end

      def build_tools
        if @collapseable
          @_.div! class: 'ibox-tools' do
            build_collapseable
          end
        end
      end

      def build_collapseable
        @_.a! class: 'collapse-link' do
          @_.i! nil, class: _get_collapse_icn
        end
      end

      private
      def default_classes
        ['ibox', 'float-e-margins']
      end
    end
  end
end
