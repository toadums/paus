KeyInput = require('coffee/input')
Player   = require('coffee/player')
Level   = require('coffee/level')
NPC   = require('coffee/npc')
{DialogManager} = require('coffee/dialog')

module.exports = class Game
  constructor: () ->
    # If the player is in an action, they can't do anything
    @IN_ACTION = false

    @canvas = undefined
    @stage = undefined
    @loader = undefined
    @player = undefined

    @keyInput = new KeyInput
    @level = undefined
    @playerSprite = undefined
    @init()
    @npcs = []

  init: () =>
    @canvas = document.getElementById("gameCanvas")
    @stage = new createjs.Stage(@canvas)
    @dialogManager = new DialogManager @

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
        regX: 0
        height: 206
        count: 12
        regY: 0
        width: 130

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

    playerPos =
      x: @canvas.width/2 - 200
      y: @canvas.height/2 + 200

    #create the player
    @player = _.extend (new Player(@playerSprite, @stage, @)), (new createjs.Container())
    @player.init(playerPos)

    @keyInput.reset()

    #ensure stage is blank and add the ship
    @stage.clear()
    @level = new Level(@stage)
    @stage.addChild @player


    for i in [0..1] by 1

      playerPos =
        x: Math.random()*@canvas.width
        y: Math.random()*@canvas.height

      #create the player
      npc = _.extend (new NPC(_.clone(@playerSprite), @stage)), (new createjs.Container())
      npc.init(playerPos)
      @stage.addChild npc

      @npcs.push npc

    #start game timer
    createjs.Ticker.addEventListener "tick", @tick  unless createjs.Ticker.hasEventListener("tick")

  tick: (event) =>
    keys = []

    # If the user is 'doing something' dont let them do anything else..
    if not @IN_DIALOG
      #handle thrust
      keys.push "up"  if @keyInput.fwdHeld
      keys.push "down"  if @keyInput.dnHeld
      keys.push "left"  if @keyInput.lfHeld
      keys.push "right"  if @keyInput.rtHeld

      @player.accelerate keys

      # Check if the user is interacting with anythin (for right now just NPCs)
      if @keyInput.actionHeld
        @player.checkActions @npcs

    else
      if @keyInput.lfHeld
        @dialogManager.keyPress "left"
        @keyInput.lfHeld = false

      else if @keyInput.rtHeld
        @dialogManager.keyPress "right"
        @keyInput.rtHeld = false

      if @keyInput.enterHeld
        @dialogManager.keyPress "enter"
        @keyInput.enterHeld = false


    #call sub ticks
    @player.tick event, @level
    @stage.x = -@player.x + @canvas.width * .5  if @player.x > @canvas.width * .5
    @stage.y = -@player.y + @canvas.height * .5  if @player.y > @canvas.height * .5
    @stage.update event

  # Open a dialog
  startDialog: (dialog) =>
    @IN_DIALOG = true
    @dialogManager.showDialog dialog

  endAction: () =>
    @IN_DIALOG = false
