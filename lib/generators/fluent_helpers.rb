require 'yaml'
FluentHelpers::Helpers.config.base = YAML.load_file(Rails.root.join('config', 'fluent_helpers.yml'))
