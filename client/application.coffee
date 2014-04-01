Game = require 'coffee/game'

# The application object.
module.exports = class Application
  @init: ->

    height = window.innerHeight
    width = window.innerWidth

    canvas = document.getElementById("gameCanvas")
    canvas = canvas.getContext "2d"

    canvas.canvas.height = Math.floor(height / 96)*96
    canvas.canvas.width =  Math.floor(width / 96)*96

    console.log "Initializing!"
    game = new Game()
