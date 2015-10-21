module FluentHelpers
  class Railtie < Rails::Railtie
    initializer "fluent_helpers.helpers" do
      ActionView::Base.send :include, FluentHelpers::Helpers
    end
  end
end
