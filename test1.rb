## testing....

["raspy", "game"].each { |l| $:.push(l) }

require 'gosu'
require 'raspy'
require 'game'




game = Game::Engine.new(Raspy::Window2D)
game.run

