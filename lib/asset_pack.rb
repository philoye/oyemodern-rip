#module Sinatra
  #module AssetPack

    #module Helpers

      #def asset_path(src)
        #local = settings.assets.local_file_for src
        #return src unless local
        #BusterHelpers.add_cache_buster(src, local)
      #end

    #end


    #class Options

      ## Returns the local file for a given URI path. (for dynamic files)
      ## Returns nil if a file is not found.
      ## TODO: consolidate with local_file_for
      #def dyn_local_file_for(file, from)
        #extension = ''
        #file.sub(/^(.*)\.([^\.]+)$/) { file, extension = $1, $2 }

        ### Remove cache-buster (/js/app.28389.js => /js/app)
        #file = $1 if file =~ /^(.*)\.[0-9]+$/

        ### Find matching file (css file might represent css/sass/less/etc.
        ## Get the list of possible preprocessor extensions (sass, less, etc.)
        #formats = Sinatra::AssetPack.tilt_formats.reject{|k,v|v != extension}.keys
        ## Let's add the original extension first
        #formats.unshift extension
        ## Let's see which exists
        #file_on_disk = nil
        #formats.each do |fmt|
          #test_file = File.join(app.root, from, "#{file}.#{fmt}")
          #if File.exist?(test_file)
            #file_on_disk = test_file
            #break
          #end
        #end
        #return file_on_disk
      #end

    #end

  #end
#end


