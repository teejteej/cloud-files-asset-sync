CloudfileAssetSync
==================
Forked from: https://github.com/phillc/cloud-files-asset-sync

This gem is intended to allow for easy movement of assets (e.g. rails public folder) to Rackspace's cloud files.

Dependencies
==================

Requires rackspace cloudfiles gem
[http://github.com/rackspace/ruby-cloudfiles/tree](http://github.com/rackspace/ruby-cloudfiles/tree)

Usage:
==================
    
Usage:
    CloudfileAsset::Sync.start :path => "#{Rails.root}/public/", :config => "#{Rails.root}/config/cloud_files.yml", :modified => false, :delete => false, :loud => true

Usage as Rake task:
	Rails 3: rake assets:sync
	Rails 3: rake assets:sync ASSET_SYNC_PATH="/var/webapps/xxx/public/assets/" ASSET_SYNC_CONFIG="/opt/config/cloud_files.yml"
	Rails 2: Use this in your rake filter after the require statements: Dir["#{Gem.searcher.find('cloud-files-asset-sync').full_gem_path}/lib/tasks/*.rake"].each { |ext| load ext }

Copyright (c) 2009 [phillc](http://kapsh.com), released under the MIT license
