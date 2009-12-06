#!/usr/bin/env ruby

require 'yaml'

module Raspy
  class MapTile
    attr :x
    attr :y
    attr :tile
    
    def initialize(xx, yy, ttile)
      @x = xx
      @y = yy
      @tile = ttile
    end
  end
  
  class Map
    attr_accessor :size_x
    attr_accessor :size_y
    
    def initialize(tileset)
      @tileset = tileset
      @tile_x = 0
      @tile_y = 0
      @tiles = []
    end
    
    def set_tile_size
      @tile_x = (@size_x / @tileset.size) + 1
      @tile_y = (@size_y / @tileset.size) + 1
    end
    
    def set_size(xx, yy)
      @size_x = xx
      @size_y = yy
      set_tile_size
    end
    
    def tile_at(xx, yy)
      wherex = xx / @tileset.size
      wherey = yy / @tileset.size
      (@tiles.select { |tile| ((tile.x == wherex) and (tile.y == wherey))}).first
    end
    
    def fill(symbol)
      tile = @tileset.get(symbol)
      @tile_x.downto(0) { |x|
        @tile_y.downto(0) { |y|
          mt = Raspy::MapTile(x,y,tile)
          @tiles.push mt
          }
        }
    end
  end
  
  class TileSet
    attr :size
    def initialize
      @tiles = {}
      @size = 16
    end
    
    def add(tilespc)
      @tiles[tilespc.symbol] = tilespc
    end
    
    def get(symbol)
      @tiles[symbol]
    end
    
    def save(filename = "tileset.yml")
      File.open(filename, "w") do |out|
        YAML.dump(@size, out)
        YAML.dump(@tiles, out)
      end
    end
    
    def load(filename = "tileset.yml")
      File.open(filename, 'r') do |inp|
        @size = YAML.load(inp)
        @tiles = YAML.load(inp)
      end
    end
    
  end
  
  class TileSpec
    attr_accessor :symbol
    attr_accessor :filename
  end 
end
