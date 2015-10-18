module FluentHelpers
  module Themes
    module Bootstrap
      class Btn < ::FluentHelpers::Helpers::Link

        # Styles
        %w[default primary success info warning danger link].each do |name|
          class_alias name, "btn-#{name}"
        end

        # Sizes
        %w[lg sm xs].each do |name|
          class_alias name, "btn-#{name}"
        end

        # States
        %w[active disabled].each do |name|
          class_alias name
        end

        def as_btn &block
          @classes << 'btn'
          on_block block
        end

        def active_if cond, &block
          active if cond
          on_block block
        end

        def disabled_if cond, &block
          disabled if cond
          on_block block
        end
      end
    end
  end
end
