module CloudfileAsset
  class SyncTask < Rails::Railtie
    if Rails::VERSION::STRING.starts_with?('3')
      rake_tasks do
        Dir[File.join(File.dirname(__FILE__),'../tasks/*.rake')].each { |f| load f }
      end
    end
  end
end