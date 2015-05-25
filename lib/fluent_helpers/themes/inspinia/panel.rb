module FluentHelpers
  module Themes
    class Inspinia::Panel < FluentHelpers::Helpers::Base

      %w[
        default
        info
        warning
        danger
        success
        primary
      ].each do |type|
        class_eval <<-RUBY
          def #{type} &block
            @type = '#{type}'
            on_block block
          end
        RUBY
      end

      def to_s
        @type ||= 'default'
        @_.div class: "panel panel-#{@type}" do
          if @name
            @_.div! @name, class: 'panel-heading'
          end
          @_.div! class: 'panel-body', &@block
        end
      end

      def named name, &block
        @name = name
        on_block block if block
        self
      end
    end
  end
end
