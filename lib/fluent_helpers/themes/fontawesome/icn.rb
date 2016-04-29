module FluentHelpers
  module Themes
    module Fontawesome
      class Icn < ::FluentHelpers::Helpers::Icn

        def css_class
          classes = ['fa', "fa-#{@type.to_s.gsub('_', '-')}"]
          case @flip
          when :horizontal
            classes << 'fa-flip-horizontal'
          when :vertical
            classes << 'fa-flip-vertical'
          when :both
            classes << 'fa-flip-horizontal' << 'fa-flip-vertical'
          end
          classes
        end
      end
    end
  end
end
