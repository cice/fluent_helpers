module FluentHelpers
  module Themes
    class Inspinia::Ibox < FluentHelpers::Helpers::Base

      def to_s
        id = @name.present? ? 'ibox-' + @name.parameterize : nil
        @_.div @options.merge(class: css_class, id: id) do
          if @name
            @_.div! class: 'ibox-title' do
              @_.h5! @name

              if @collapseable
                @_.div! class: 'ibox-tools' do
                  @_.a! class: 'collapse-link' do
                    @_.i! nil, class: _get_collapse_icn
                  end
                end
              end
            end
          end
          @_.div! class: 'ibox-content', style: _get_content_style, &@block
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

      private
      def default_classes
        ['ibox', 'float-e-margins']
      end
    end
  end
end
