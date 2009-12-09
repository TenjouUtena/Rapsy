#!/usr/bin/env ruby

require 'gosu'

module Raspy
  class AssetManager
    def initialize
      @loadpath = []
      @loadpath.push 'assets'
      
      @images = {}
      @sounds = {}
    end
    
    def find_file(filename)
      (@loadpath.select {|path| File.exist?(path + '/' + filename)}).first + "/" + filename
    end
    
    def get_image(filename, window)
      if not (@images.has_key? filename)
        filepath = find_file(filename)
        @images[filename] = Gosu::Image.new(window, filepath, false)
      end
      @images[filename]
    end
  end
end


