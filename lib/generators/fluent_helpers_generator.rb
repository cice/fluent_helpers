class FluentHelpersGenerator < Rails::Generators::Base
  source_root File.expand_path(File.dirname(__FILE__))

  def copy_initializer
    copy_file "fluent_helpers.rb", "config/initializers/fluent_helpers.rb"
  end
end
