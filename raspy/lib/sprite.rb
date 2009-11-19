#!/usr/bin/env ruby


module Raspy
  class Sprite
    attr_accessor :window
    
    def update_logic(delta)
      
    end
    
    def update(delta)
      
    end
    
    def render
    end
    
  end
  
  class SpriteGroup
    
    attr_accessor :sprites
    
    def initialize(window = nil)
      @window = window
      self.sprites = []
      @threads = ThreadGroup.new
      
    end
    
    def threaded
      self.sprites.each { |sprite|
        t = Thread.new {
          yield sprite if block_given?
        }
        ##t.run
        @threads.add t
        }
      @threads.list.each { |t| t.join() }
    end
    
    def update_logic(delta)
      if @window.multithread
        threaded { |s| s.update_logic(delta) }
      else
        self.sprites.each { |s| s.update_logic(delta) }
      end
    end
    
    def update_position(delta)
      if @window.multithread
        threaded { |s| s.update_position(delta) }
      else
        self.sprites.each { |s| s.update_position(delta) }
      end
    end
    
    def update(delta)
      if @window.multithread
        threaded { |s| s.update(delta) }
      else
        self.sprites.each { |s| s.update(delta) }
      end
    end
    
    def render
      self.sprites.each { |s| s.render }
    end
    
    def push(sprite)
      sprites.push(sprite)
      sprite.window = @window
    end
    
  end
end

