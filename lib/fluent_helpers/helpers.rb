module FluentHelpers
  module Helpers
    autoload :Generator,          'fluent_helpers/helpers/generator'

    autoload :Using,              'fluent_helpers/helpers/using'

    autoload :Base,               'fluent_helpers/helpers/base'
    autoload :Link,               'fluent_helpers/helpers/link'
    autoload :Table,              'fluent_helpers/helpers/table'
    autoload :Res,                'fluent_helpers/helpers/res'

    autoload :Icn,                'fluent_helpers/helpers/icn'

    include Using::Mixin

    def btn
      respecting_using Link.new(self).as_btn
    end

    def link
      respecting_using Link.new(self)
    end

    def res *resource
      respecting_using Res.new(self, resource)
    end

    def icn type = nil
      @icn ||= Icn.new self
      @icn.type type
    end

    def table collection, &block
      respecting_using Table.new(self, collection, block)
    end
  end
end
