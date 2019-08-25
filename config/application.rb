require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'

Bundler.require(*Rails.groups)

module BiteLee
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
    config.generators { |g| g.orm :active_record, primary_key_type: :uuid }
    config.active_record.schema_format = :sql
  end
end
