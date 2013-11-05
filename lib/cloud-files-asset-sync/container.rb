module CloudfileAsset
  class Container
    def initialize
      config
      container
    end
    def config
      @config ||= YAML.load_file(CloudfileAsset::yml_config)[ENV['CLOUDFILES_CONFIG_ENV'] || Rails.env].symbolize_keys
    end

    def container
      @container ||=  CloudFiles::Connection.new(:username => config[:username], :api_key => config[:api_key], :snet => config[:service_net]).container(config[:assets_container])
    end

    # TODO: Is this the same as Action Pack -> ActionView::Helpers::AssetTagHelper.asset_file_path and collect_asset_files
    def local_files
      @local_files ||= CloudfileAsset::Local.public_files.collect{|filename| CloudfileAsset::Local.make_relative(filename)}
    end
    
    def remote_files
      unless @remote_files
        @remote_files = []

        while @container.count != @remote_files.size
          @remote_files += @container.objects :marker => @remote_files.last
        end
      end
      
      @remote_files
    end
    
    def upload_file(filename, extra_headers = {})
      retry_operation do
        file_headers = {'Expires' => CGI.rfc1123_date(Time.now + 10.year), 'Cache-Control' => 'public, max-age=315576000', 'Content-Type' => Mime::Type.lookup_by_extension(File.extname(filename)[1..-1]).to_s}
        file_headers = file_headers.merge extra_headers
        
        object = @container.create_object(filename, false)
        object.load_from_filename(CloudfileAsset::Local.make_absolute(filename), file_headers)
      end
    end
    
    def delete_file(filename)
      retry_operation do
        @container.delete_object(filename)
      end
    end
    
    def new_files
      local_files - remote_files
    end
    
    def same_files
      local_files & remote_files
    end
    
    #not perfect, but could save some bandwith perhaps
    def modified_files
      remote_details = @container.list_objects_info
      same_files.reject do |file|
        (remote_details[file][:last_modified] <=> File.mtime(CloudfileAsset::Local.make_absolute(file))) == 1
      end
    end

    def deleted_files
      remote_files - local_files
    end
    
    def retry_operation
      retries_left = 10
      sleep_time_seconds = 4

      while retries_left > 0 do
        begin
          yield
          break
        rescue Exception => e
          puts "Retrying operation [#{e.message}]: #{retries_left} retries left..."
        end

        retries_left -= 1
        Kernel.sleep sleep_time_seconds
      end
    end
    
  end
end