require 'fluent_helpers/helpers/base'

module FluentHelpers
  module Themes
    module Bootstrap
      class TextSearch < ::FluentHelpers::Helpers::Base
        def initialize(template)
          super template
          @params = template.params.except :controller, :action
        end

        def exclude_param(*params, &block)
          @params = @params.except *params
          on_block block
        end

        def for_param(param, &block)
          @param = param
          @value = @params[param]
          @params = @params.except param
          on_block block
        end

        def with_icon(icon, &block)
          @icon = icon
          on_block block
        end

        def placeholder(placeholder, &block)
          @placeholder = placeholder
          on_block block
        end

        def focus(&block)
          @focus = true
          on_block block
        end

        def to_s
          options = { class: css_class + ['form-control'] }
          options[:placeholder] = @placeholder if @placeholder

          @_.form_tag @template.request.original_fullpath, method: :get, enforce_utf8: false, class: 'form-inline' do
            @params.each do |k, v|
              @_.hidden_field_tag! k, v
            end

            @_.div! class: 'form-group' do
              @_.div! class: 'input-group' do
                @_.span! class: 'input-group-addon' do
                  @_.concat @_.icn.for(@icon || 'search')
                end

                @_.text_field_tag! @param, @value, options
              end
            end

            if @focus
              @_.javascript_tag! <<-JS
                $('input[name=#{@param}]').focus()[0].select();
              JS
            end
          end
        end
      end
    end
  end
end
