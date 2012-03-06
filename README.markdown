CloudfileAssetSync
==================
This gem is intended to allow for easy movement of assets (e.g. rails public folder) to Rackspace's cloud files.

Dependencies
==================

Requires rackspace cloudfiles gem
[http://github.com/rackspace/ruby-cloudfiles/tree](http://github.com/rackspace/ruby-cloudfiles/tree)

Usage:
==================
    
Usage:
    CloudfileAsset::Sync.start :path => "#{Rails.root}/public/", :config => "#{Rails.root}/config/cloud_files.yml", :modified => false, :delete => false, :loud => true

Copyright (c) 2009 [phillc](http://kapsh.com), released under the MIT license
