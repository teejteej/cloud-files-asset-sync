require 'pathname'

module CloudfileAsset
  module Local
    class << self
      def public_files
        recursive_files(Pathname.new(CloudfileAsset::local_public_path)).collect(&:to_s)
      end
      
      # TODO: Is this the same as Action Pack -> ActionView::Helpers::AssetTagHelper private methods?
      def make_relative(filename)
        filename.split(CloudfileAsset::local_public_path).last
      end
      def make_absolute(filename)
        [CloudfileAsset::local_public_path, filename].join
      end
      
      private
      
      def recursive_files(path)
        path.children.collect do |child|
          if child.file?
            child
          elsif child.directory?
            recursive_files child
          end
        end.select { |x| x }.flatten(1)
      end
      
    end
  end
end