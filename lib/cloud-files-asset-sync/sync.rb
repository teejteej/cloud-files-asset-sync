module CloudfileAsset
  module Sync
    class << self
      def start(options = {})
        CloudfileAsset::local_public_path = options[:path]
        CloudfileAsset::yml_config = options[:config]
        
        container = CloudfileAsset::Container.new
        new_files = container.new_files
        modified_files = options[:modified] ? container.modified_files : []
        deleted_files = options[:delete] ? container.deleted_files : []
        begin_time = Time.new

        if options[:single_file]
          container.upload_file options[:single_file]
          puts "uploading file - #{options[:single_file]}" if options[:loud]
        end

        (new_files + modified_files).each do |file|
          if options[:loud]
            start = Time.new
            puts "uploading file - #{file}"
          end

          container.upload_file(file)

          if options[:loud]
            now = Time.new
            diff =  now - start
            total = now - begin_time
            puts "done uploading file - #{file} - #{diff} sec, #{total}"
          end

          sleep options[:wait].to_i if not options[:wait].nil?
        end
        puts "Done uploading" if options[:loud]
        
        deleted_files.each do |file|
          puts "deleting file - #{file}" if options[:loud]
          container.delete_file(file)
        end
        puts "Done cleaning up" if options[:loud]
      end
      
      def delete_all(loud=false)
        container = CloudfileAsset::Container.new
        container.remote_files.each do |file|
          container.delete_file(file)
        end
        puts "Done deleteing all remote files" if loud
      end
    end
  end
end