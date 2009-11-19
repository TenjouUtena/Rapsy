#!/usr/bin/env ruby

require 'raspy'
require 'gosu'

class TestSprite < Raspy::Sprite
  def initialize(number)
    super()
    @number = number
    @x = number*15
    @y = number*15
    @angle = (((number)/28.0)*Math::PI).radians_to_gosu
    @count = 0
    @corner1 = Gosu::Color.new(0xFFFF0000)
    @corner2 = Gosu::Color.new(0xFF00FF00)
    @corner3 = Gosu::Color.new(0xFF0000FF)
    @corner4 = Gosu::Color.new(0xFFFFFFFF)
  end
  
  def update_logic(delta)
    #puts @number
  end
  
  def update_position(delta)
    @x += Gosu::offset_x(@angle,delta/10.0)
    @y += Gosu::offset_y(@angle,delta/10.0)
  end
  
  def update(delta)
    @count += 0.05
    @corner1.red=Integer((Math.sin(@count+@number) * 128) + 127)
    @corner2.green=Integer((Math.sin(@count+@number) * 128) + 127)
    @corner3.blue=Integer((Math.sin(@count+@number) * 128) + 127)
    
  end
  
  def render
    window.draw_quad( @x   , @y   , @corner1,
                      @x+20, @y   , @corner2,
                      @x+20, @y+20, @corner3,
                      @x   , @y+20, @corner4)
  end
end

module Game
  class InputHandler < Raspy::InputHandler
    def initialize(engine)
      @engine = engine
    end
    
    def button_down(id)
      case id
        when Gosu::KbP
          if @engine.window.paused?
            @engine.window.unpause
          else
            @engine.window.pause
          end
        end
      end
  end
  class Engine
    attr_accessor :window
    def initialize(window_type)
      @window = window_type.new(800, 600)
      @window.debug = true
      
      @window.input_handler = Game::InputHandler.new(self)
      
      @sprites = Raspy::SpriteGroup.new(@window)
      
      [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28].each { |s|
        s = TestSprite.new(s)
        @sprites.push(s)
      }
      
      @window.sprites.push(@sprites)
      
    end
    
    def run
      @window.show
    end
  end
end
