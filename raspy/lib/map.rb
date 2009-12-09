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
      @tiles = {}
      @todraw = []
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
          mt = Raspy::MapTile.new(x,y,tile)
          @tiles["#{x},#{y}"] =  mt
          }
        }
    end
    
    def convert(tile, viewport)
      retary = []
      retary.push((tile.x*@tileset.size) - viewport.x)
      retary.push((tile.y*@tileset.size) - viewport.y)
      retary
      
    end
    
    def render(window)
      mapxs = (window.viewport.xsize / @tileset.size) + 1
      mapys = (window.viewport.ysize / @tileset.size) + 1
      mapx = (Integer(window.viewport.x) / @tileset.size)
      mapy = (Integer(window.viewport.y) / @tileset.size)

      mapx.upto(mapx+mapxs) { |x|
        mapy.upto(mapy+mapys) { |y|
          tile = @tiles["#{x},#{y}"]
          if tile
            rr = convert(tile, window.viewport)
            $assets.get_image(tile.tile.filename, window).draw(rr[0],rr[1],0) if window.viewport.render?(rr, @tileset.size)
          end
        }
      }
    end
    
  end
  
  class TileSet
    attr :size
    def initialize
      @tiles = {}
      @size = 32
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
