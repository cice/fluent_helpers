module FluentHelpers
  module Helpers
    autoload :Generator,          'fluent_helpers/helpers/generator'

    autoload :Base,               'fluent_helpers/helpers/base'
    autoload :Link,               'fluent_helpers/helpers/link'
    autoload :Using,              'fluent_helpers/helpers/using'
    autoload :Res,                'fluent_helpers/helpers/res'

    def btn
      with_using Link.new(self).as_btn
    end

    def link
      with_using Link.new(self)
    end

    def res *resource
      with_using Res.new(self, resource)
    end

    def using
      @old_using = @using
      @using = Using.new @using do
        @using = @old_using
      end
    end

    def icn type = nil
      @icn ||= Icn.new self
      @icn.type type
    end

    def table collection, &block
      with_using Table.new(self, collection, block)
    end

    protected
    def with_using helper
      @using.__apply__ helper if @using
      helper
    end
  end
end
