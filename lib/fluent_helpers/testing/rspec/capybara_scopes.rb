module FluentHelpers
  module Testing
    module Rspec
      module CapybaraScopes
        def within_ibox(name, &block)
          title = find '.ibox-title h5', text: name
          ibox = title.find :xpath, '../..'
          content = ibox.find '.ibox-content'

          within content, &block
        end

        def within_page_content(&block)
          within '#page-content', &block
        end

        def table_for(name)
          find "table.table.#{name}"
        end
      end

      ::Capybara::Session.send :include, CapybaraScopes
      ::RSpec.configure do |config|
        config.include CapybaraScopes
      end
    end
  end
end
