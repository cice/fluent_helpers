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
          build_heading
          build_body
        end
      end

      def named name, &block
        @name = name
        on_block block if block
        self
      end

      protected
      def build_body
        @_.div! class: 'panel-body', &@block
      end

      def build_heading
        if @name
          @_.div! @name, class: 'panel-heading'
        end
      end
    end
  end
end
