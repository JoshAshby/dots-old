require "bundler/setup"
require "ash_frame"

class App
  extend AshFrame::Root
end

Bundler.require :default, App.environment
