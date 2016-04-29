module FluentHelpers
  module Helpers
    autoload :Generator,          'fluent_helpers/helpers/generator'

    autoload :Using,              'fluent_helpers/helpers/using'

    autoload :Base,               'fluent_helpers/helpers/base'
    autoload :Link,               'fluent_helpers/helpers/link'
    autoload :Table,              'fluent_helpers/helpers/table'
    autoload :Res,                'fluent_helpers/helpers/res'
    autoload :Switch,             'fluent_helpers/helpers/switch'

    autoload :Icn,                'fluent_helpers/helpers/icn'

    include Using::Mixin
    include ActiveSupport::Configurable

    def switch
      respecting_using switch_class.new(self)
    end

    def btn
      respecting_using link_class.new(self).as_btn
    end

    def link
      respecting_using link_class.new(self)
    end

    def res(*resource)
      respecting_using res_class.new(self, resource)
    end

    def icn(type = nil)
      icn_class.new(self).type(type)
    end

    def table(collection, &block)
      respecting_using table_class.new(self, collection, block)
    end

    protected
    def switch_class
      Switch
    end

    def table_class
      Table
    end

    def icn_class
      Icn
    end

    def link_class
      Link
    end

    def res_class
      Res
    end
  end
end
