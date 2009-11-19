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
      @lastelapse = 0
      @elpasedelta = 0

    end
    
    def tick
      delta = Gosu::milliseconds - @ticks
      @lasttick = delta
      @ticks += delta
      @pause_ticks += delta unless @paused
      begin
        @elapsedelta = elapsed - @lastelapsed
      rescue
      end
      
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
