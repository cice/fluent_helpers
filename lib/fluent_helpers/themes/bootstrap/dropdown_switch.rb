require 'fluent_helpers/helpers/base'

module FluentHelpers
  module Themes
    module Bootstrap
      class DropdownSwitch < ::FluentHelpers::Helpers::Base
        def initialize(template)
          super template
          @params = template.params.except :controller, :action
          classes :btn, :dropdown_toggle
        end

        def exclude_param(*params, &block)
          @params = @params.except *params
          on_block block
        end

        def for_param(param, collection, label_method = :name, value_method = :id, &block)
          @param = param
          @current_value = @params[@param]

          @label_method = label_method
          @value_method = value_method
          @collection = collection
          on_block block
        end

        def with_blank(blank_label, &block)
          @blank_label = blank_label
          on_block block
        end

        def with_default(default, &block)
          @default = default
          on_block block
        end

        def style(style, &block)
          @style = style
          on_block block
        end

        def to_s
          current = _find_obj(@current_value) || @default
          current_label = current ? _proc_or_accessor(current, @label_method) : @blank_label

          @_.div class: 'btn-group' do
            @_.button! class: css_class, data: { toggle: 'dropdown' } do
              if @block
                @_.capture! &@block
              else
                @_.concat current_label
              end
              @_.concat ' '
              @_.span! '', class: 'caret'
            end

            @_.ul! class: 'dropdown-menu', role: 'menu' do
              @collection.each do |obj|
                value = _proc_or_accessor(obj, @value_method)
                label = _proc_or_accessor(obj, @label_method)
                cls = 'active' if current == obj

                @_.li! class: cls do
                  @_.link_to! label, @params.merge(@param => value)
                end
              end
            end
          end
        end

        protected
        def _find_obj(value)
          value.present? && @collection.find { |obj| _proc_or_accessor(obj, @value_method).to_s == value.to_s }
        end

        def _get_options
          @collection.map do |obj|
            value = _proc_or_accessor obj, @value_method
            label = _proc_or_accessor obj, @label_method

            [value, label]
          end
        end

        def css_class
          super + ["btn-#{@style || 'white'}"]
        end
      end
    end
  end
end
