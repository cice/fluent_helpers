module FluentHelpers
  module Themes
    module Bootstrap
      class Badge < ::FluentHelpers::Helpers::Base
        def initialize(template, block = nil)
          super(template, block)
          classes :badge
        end

        %w[default primary success info warning danger link].each do |name|
          class_alias name, "badge-#{name}"
        end

        def style(style, &block)
          classes "badge-#{style}"
          on_block block
        end

        def iconed(icn, &block)
          @content = @_.icn.for icn
          on_block block
        end

        def yes_no(true_false, true_icon = :yes, false_icon = :no, &block)
          if true_false
            primary.iconed true_icon, &block
          else
            danger.iconed false_icon, &block
          end
        end

        def to_s
          @_.span @options.merge(class: css_class) do
            @_.concat @content
            @_.capture! &@block if @block
          end
        end
      end
    end
  end
end
