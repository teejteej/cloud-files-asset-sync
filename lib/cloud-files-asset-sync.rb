require "cloud-files-asset-sync/version"

require 'cloudfiles'
require 'yaml'
require 'cloud-files-asset-sync/sync'
require 'cloud-files-asset-sync/local'
require 'cloud-files-asset-sync/container'
require 'cloud-files-asset-sync/railtie' if defined?(Rails)

module CloudfileAsset
  
  class << self
    attr_accessor :local_public_path
    attr_accessor :yml_config
  end
end
