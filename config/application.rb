require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IneyeWebsite
  class Application < Rails::Application
    config.time_zone = 'Beijing'
    config.i18n.available_locales = [ :en, :'zh-CN' ]
    config.i18n.default_locale    = :'zh-CN'
    config.time_to_lives = {
      validate_code_second: 900
    }
  end
end
