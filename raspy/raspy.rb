#!/usr/bin/env ruby

$:.push("#{File.dirname(__FILE__)}/lib")

require 'assetmanager'

$assets = Raspy::AssetManager.new

require 'input'
require 'timer'
require 'viewport'
require 'map'

require 'window2d'
require 'sprite'







