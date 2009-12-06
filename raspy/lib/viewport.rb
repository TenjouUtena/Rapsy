#!/usr/bin/env ruby



module Raspy
  class MapTooSmallError < Exception
  end
  
  class Viewport
    attr :x
    attr :y
    
    def initialize(mapx, mapy, xsize=800, ysize=600 )
      @mapx = mapx
      @mapy = mapy
      @xsize = xsize
      @ysize = ysize
      
      if (mapx < xsize) or (mapy < ysize)
        raise MapTooSmallError
      end
      
    end
    
    def normalize
      @x = 0 if @x < 0
      @y = 0 if @y < 0
      @x = (@mapx - @xsize) if @x > (@mapx - @xsize)
      @y = (@mapy - @ysize) if @y > (@mapy - @ysize)
    end
    
    # This function moves the viewport a given delta
    def move_dist(deltx, delty)
      @x += deltx
      @y += delty
      normalize
    end
    
    # This function moves the viewport to a given location
    def move_to(xx, yy)
      @x = xx
      @y = yy
      normalize
    end
    
  end
end
