#!/usr/bin/env ruby

require 'gosu'

module Raspy
  class Timer
    def initialize(win=nil)
      @window = win
      
      @ticks = Gosu::milliseconds
      @machticks = @ticks
      @pause_ticks = @ticks
      @paused_at = 0
      @pause_accum = 0
      @paused = false
      @lasttick = 0
      @lastelapsed = 0
      @elpasedelta = 0
      #@window.debugtext += "Elapsed: #{self.elapsed}\nTicks: #{self.ticks}\nLastTick: #{self.lasttick}\nElapseDelta: #{self.elapsedelta}"
    end
    
    def tick
      delta = Gosu::milliseconds - @ticks
      
      
      @lasttick = delta
      @ticks += delta
      @pause_ticks += delta unless @paused
      @elapsedelta = elapsed - @lastelapsed
      @lastelapsed = elapsed
      @lasttick
    end
    
    def ticks
      @ticks - @machticks
    end
    
    def paused?
      @paused
    end
    
    def pause
      @paused_at = @ticks
      @paused = true
    end
    
    def unpause
      delta = Gosu::milliseconds - @paused_at
      @pause_accum += delta
      @paused = false
    end
    
    def elapsed
      if paused?
        (@paused_at - (@machticks + @pause_accum))
      else
        @ticks - (@pause_accum + @machticks)
      end
    end
    
    def elapsedelta
      @elapsedelta
    end
    
    def lasttick
      @lasttick
    end
    
  end
  
end
