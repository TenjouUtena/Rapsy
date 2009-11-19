#!/usr/bin/env ruby


module Raspy
  class Sprite
    attr_accessor :window
    
    def update_logic(delta)
    end
    
    def update_position(delta)
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
    
    def update_logic(delta)
      self.sprites.each { |s| s.update_logic(delta) }
    end
    
    def update_position(delta)
      self.sprites.each { |s| s.update_position(delta) }
    end
    
    def update(delta)
      self.sprites.each { |s| s.update(delta) }
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

