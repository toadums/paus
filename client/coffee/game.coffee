KeyInput = require('coffee/input')
Player   = require('coffee/player')
Level   = require('coffee/level')

module.exports = class Game
  constructor: () ->
    @canvas = undefined
    @stage = undefined
    @loader = undefined
    @player = undefined

    @keyInput = new KeyInput
    @level = undefined
    @playerSprite = undefined
    @init()

  init: () =>
    @canvas = document.getElementById("gameCanvas")
    @stage = new createjs.Stage(@canvas)

    manifest = [
      src: "images/runningRpg.png"
      id: "player"
    ]
    @loader = new createjs.LoadQueue(false)
    @loader.addEventListener "complete", @handleComplete
    @loader.loadManifest manifest

    @stage.update() #update the stage to show text

  handleClick: =>
    @canvas.onclick = null

  handleComplete: (event) =>
    data = new createjs.SpriteSheet(
      images: [@loader.getResult("player")]
      frames:
        regX: 100
        height: 292
        count: 12
        regY: 165 / 2
        width: 165

      animations:
        up: [0, 2, "up"]
        right: [3, 5, "right"]
        down: [6, 8, "down"]
        left: [9, 11, "left"]
        left_idle: [9, 9]
        right_idle: [3, 3]
        up_idle: [0, 0]
        down_idle: [6, 6]
    )

    @playerSprite = new createjs.Sprite(data, "right_idle")
    @playerSprite.framerate = 10

    @restart()

  #reset all game logic
  restart: =>
    #hide anything on stage
    @stage.removeAllChildren()

    #create the player
    @player = _.extend (new Player(@playerSprite, @stage)), (new createjs.Container())
    @player.init()
    @player.x = @canvas.width/2
    @player.y = @canvas.height/2

    @player.width = 165;
    @player.height = 292;

    @keyInput.reset()

    #ensure stage is blank and add the ship
    @stage.clear()
    @level = new Level(@stage)
    @stage.addChild @player

    #start game timer
    createjs.Ticker.addEventListener "tick", @tick  unless createjs.Ticker.hasEventListener("tick")

  tick: (event) =>
    keys = []

    #handle thrust
    keys.push "up"  if @keyInput.fwdHeld
    keys.push "down"  if @keyInput.dnHeld
    keys.push "left"  if @keyInput.lfHeld
    keys.push "right"  if @keyInput.rtHeld

    @player.accelerate keys

    #call sub ticks
    @player.tick event, @level
    @stage.x = -@player.x + @canvas.width * .5  if @player.x > @canvas.width * .5
    @stage.y = -@player.y + @canvas.height * .5  if @player.y > @canvas.height * .5
    @stage.update event

