namespace :assets do
  desc 'Assets Syncing'
  task :sync => :environment do |t, args|
    CloudfileAsset::Sync.start :path => ENV['ASSET_SYNC_PATH'] || "#{Rails.root}/public/", :config => ENV['ASSET_SYNC_CONFIG'] || "#{Rails.root}/config/cloud_files.yml", :modified => false, :delete => false, :loud => true
  end
end