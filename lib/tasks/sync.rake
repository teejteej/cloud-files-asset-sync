namespace :assets do
  desc 'Assets Syncing'
  task :sync => :environment do |t, args|
    extra_headers = {}

    if ENV['EXTRA_HEADERS']
      ENV['EXTRA_HEADERS'].split(';').each do |header|
        key = header.split('=').first.strip
        value = header.split('=').last.strip
        
        extra_headers[key] = value
      end
    end
    
    CloudfileAsset::Sync.start :path => ENV['ASSET_SYNC_PATH'] || "#{Rails.root}/public/", :config => ENV['ASSET_SYNC_CONFIG'] || "#{Rails.root}/config/cloud_files.yml", :modified => false, :delete => false, :loud => true, :extra_headers => extra_headers
  end
end