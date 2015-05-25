module FluentHelpers
  module Helpers
    autoload :Generator,          'fluent_helpers/helpers/generator'

    autoload :Using,              'fluent_helpers/helpers/using'

    autoload :Base,               'fluent_helpers/helpers/base'
    autoload :Link,               'fluent_helpers/helpers/link'
    autoload :Table,              'fluent_helpers/helpers/table'
    autoload :Res,                'fluent_helpers/helpers/res'

    include Using::Mixin

    def btn
      with_using Link.new(self).as_btn
    end

    def link
      with_using Link.new(self)
    end

    def res *resource
      with_using Res.new(self, resource)
    end

    def icn type = nil
      @icn ||= Icn.new self
      @icn.type type
    end

    def table collection, &block
      with_using Table.new(self, collection, block)
    end
  end
end
