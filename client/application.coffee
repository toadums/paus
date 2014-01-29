Game = require 'coffee/game'

# The application object.
module.exports = class Application
  @init: ->
    console.log "Initializing!"
    game = new Game()


