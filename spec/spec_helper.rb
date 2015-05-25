require 'bundler/setup'
Bundler.setup

require 'active_support/all'
require 'action_view'
require 'fluent_helpers'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
end
