require_relative 'TerraNovaConfig'
require 'fileutils'

#Moves any uploaded config/db files to proper locations at this time
if File.file?("tmp/UploadedConfig.json")
  if Rails.env.development? 
    FileUtils.rm("DevTerraNovaConfig.json")
    FileUtils.move("tmp/UploadedConfig.json", "DevTerraNovaConfig.json") 
  else 
    FileUtils.rm("DevTerraNovaConfig.json")
    FileUtils.move("tmp/UploadedConfig.json", "DevTerraNovaConfig.json")  
  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

TerraNovaConfig=loadConfig

module TerraNova
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = TerraNovaConfig["timezone"]
  end
end
