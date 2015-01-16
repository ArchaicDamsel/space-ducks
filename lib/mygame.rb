require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require "mygame/version"
require "mygame/models/player"
require "mygame/controllers/window"
require "mygame/models/zorder"
require "mygame/models/star"

module Mygame

  # Your code goes here...
  def self.start
    Window.new.show
  end
end
