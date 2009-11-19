#!/usr/bin/env ruby

require 'gosu'
require 'timer'

module Raspy
  class Window2D < Gosu::Window
    
    attr_accessor :screen_x
    attr_accessor :screen_y
    attr_accessor :fullscreen
    attr_accessor :refresh
    attr_accessor :sprites
    attr_accessor :ui
    attr_accessor :timer
    attr_accessor :input_handler
    attr_accessor :debug
    
    def initialize(x=640, y=480, fullscreen=false, refresh=20)
      super(x,y,fullscreen,refresh)
      
      self.screen_x = x 
      self.screen_y = y
      self.fullscreen = fullscreen
      self.refresh = refresh
      
      @debugfont = Gosu::Font.new(self, 'Ariel', 18)
      
      reset
      
      self.caption = 'Hello World!'
    end
    
    def reset
      self.ui = nil
      self.timer = Raspy::Timer.new
      self.sprites = []
      
      self.input_handler = nil
      self.debug = false
    end
    
    def pause
      self.timer.pause
    end
    
    def unpause
      self.timer.unpause
    end
    
    def paused?
      self.timer.paused?
    end
    
    def button_down(id)
      self.input_handler.button_down(id) if self.input_handler
    end
    
    def button_up(id)
      self.input_handler.button_up(id) if self.input_handler
    end
    
    def button_down?(id)
      self.input_handler.button_down?(id) if self.input_handler
    end
    
    def update
      delta = self.timer.tick
      self.sprites.each {|s| s.update_logic(self.timer.elapsedelta)} if not self.paused?
      self.sprites.each {|s| s.update_position(self.timer.elapsedelta)} if not self.paused?
      self.sprites.each {|s| s.update(delta)}
      
      if self.debug
        @debugfont.draw_rel("Elapsed: #{self.timer.elapsed}", self.screen_x-10, 10, 999, 1.0, 0.0)
        @debugfont.draw_rel("Ticks: #{self.timer.ticks}", self.screen_x-10, 30, 999, 1.0, 0.0)
        @debugfont.draw_rel("LastTick: #{self.timer.lasttick}", self.screen_x-10, 50, 999, 1.0, 0.0)
        @debugfont.draw_rel("ElapseDelta: #{self.timer.elapsedelta}", self.screen_x-10, 70, 999, 1.0, 0.0)
      end
    end
    
    def draw
      self.sprites.each {|s| s.render}
    end
    
  end
end