module FluentHelpers
  module Helpers
    class Using < ActiveSupport::ProxyObject
      module Mixin
        def using
          @old_using = @using
          @using = Using.new @using do
            @using = @old_using
          end
        end

        protected
        def respecting_using helper
          @using.__apply__ helper if @using
          helper
        end
      end

      def initialize prev = nil, &callback
        @calls = []
        @prev = prev
        @callback = callback || -> {}
      end

      def __prev__
        @prev
      end

      def __apply__ helper
        @prev.__apply__ helper if @prev

        @calls.each do |call_args|
          helper.__send__ *call_args
        end
      end

      protected
      def method_missing name, *args, &block
        @calls << [name, *args]
        if block
          block.call
          @callback.call
          nil
        else
          self
        end
      end
    end
  end
end
