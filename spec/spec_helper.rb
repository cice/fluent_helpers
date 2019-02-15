require 'bundler/setup'
Bundler.setup

require 'simplecov'
SimpleCov.start

require 'rspec-html-matchers'

require 'active_support/all'
require 'action_view'
require 'fluent_helpers'
require 'byebug'
require 'yaml'

require 'fluent_helpers/testing'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

FluentHelpers::Helpers.config.base = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__), "fixtures/icons.yml")))

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.include FluentHelpers::Testing
end

::TemplateStub = FluentHelpers::Testing::TemplateStub
