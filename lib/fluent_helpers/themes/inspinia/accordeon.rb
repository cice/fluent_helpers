module FluentHelpers
  module Themes
    class Inspinia::Accordeon < FluentHelpers::Helpers::Base
      class PanelItem < ::Struct.new(:name, :block)
        def id
          name.parameterize
        end
      end

      def panel(name, &block)
        @panels ||= []

        @panels << PanelItem.new(name, block)
      end

      def to_s
        @block.call self
        @panels ||= []
        @id ||= ::SecureRandom.uuid
        @_.div class: "panel-group", id: @id do
          @panels.each do |panel|
            @_.div! class: 'panel panel-default' do
              @_.div! class: 'panel-heading' do
                @_.h5 class: 'panel-title' do
                  @_.a panel.name, href: "##{panel.id}", data: { parent: "##{@id}", toggle: 'collapse' }
                end
              end

              @_.div! class: 'panel-collapse collapse', id: panel.id do
                @_.div class: 'panel-body', &panel.block
              end
            end
          end
        end
      end
    end
  end
end

