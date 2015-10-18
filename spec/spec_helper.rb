require 'bundler/setup'
Bundler.setup

require 'simplecov'
SimpleCov.start

require 'rspec-html-matchers'

require 'active_support/all'
require 'action_view'
require 'fluent_helpers'
require 'byebug'

require 'fluent_helpers/testing'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.include FluentHelpers::Testing
end

::TemplateStub = FluentHelpers::Testing::TemplateStub
