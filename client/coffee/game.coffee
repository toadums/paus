KeyInput = require('coffee/input')
Player   = require('coffee/player')
Monster   = require('coffee/monster')
Level   = require('coffee/level')
NPC   = require('coffee/npc')
{DialogManager} = require('coffee/dialog')
_npcs = require 'coffee/data/npcs'

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
    @monsterSprite = undefined
    @monsterSprite2 = undefined
    @monsterSprite3 = undefined
    @monsterSprite4 = undefined
    @monsterSprite5 = undefined
    @monsterSpritered = undefined
    @monsterSprite2red = undefined
    @monsterSprite3red = undefined
    @monsterSprite4red = undefined
    @monsterSprite5red = undefined
    @blood = undefined

    @init()
    @npcs = []
    @monsters = []

  init: () =>
    @canvas = document.getElementById("gameCanvas")
    @stage = new createjs.Stage(@canvas)
    @dialogManager = new DialogManager @

    manifest = [
      {
        src: "images/runningRpg.png"
        id: "player"
      },
      {
        src: "images/bunny1.png"
        id: "monster"
      },
      {
        src: "images/bunny2.png"
        id: "monster2"
      },
      {
        src: "images/bunny3.png"
        id: "monster3"
      },
      {
        src: "images/bunny4.png"
        id: "monster4"
      },
      {
        src: "images/bunny5.png"
        id: "monster5"
      },
      {
        src: "images/bunny1red.png"
        id: "monsterred"
      },
      {
        src: "images/bunny2red.png"
        id: "monster2red"
      },
      {
        src: "images/bunny3red.png"
        id: "monster3red"
      },
      {
        src: "images/bunny4red.png"
        id: "monster4red"
      },
      {
        src: "images/bunny5red.png"
        id: "monster5red"
      },
      {
        src: "images/blood.png"
        id: "bloodPool"
      }
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

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite = new createjs.Sprite(data, "right_idle")
    @monsterSprite.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster2")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite2 = new createjs.Sprite(data, "right_idle")
    @monsterSprite2.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster3")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite3 = new createjs.Sprite(data, "right_idle")
    @monsterSprite3.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster4")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite4 = new createjs.Sprite(data, "right_idle")
    @monsterSprite4.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster5")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite5 = new createjs.Sprite(data, "right_idle")
    @monsterSprite5.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monsterred")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSpritered = new createjs.Sprite(data, "right_idle")
    @monsterSpritered.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster2red")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite2red = new createjs.Sprite(data, "right_idle")
    @monsterSprite2red.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster3red")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite3red = new createjs.Sprite(data, "right_idle")
    @monsterSprite3red.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster4red")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite4red = new createjs.Sprite(data, "right_idle")
    @monsterSprite4red.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("monster5red")]
      frames:
        regX: 0
        height: 130
        count: 12
        regY: 0
        width: 130

      animations:
        down: [0, 2, "down"]
        left: [3, 5, "left"]
        right: [6, 8, "right"]
        up: [9, 11, "up"]
        left_idle: [4,4]
        right_idle: [7,7]
        up_idle: [9, 9]
        down_idle: [0, 0]
    )

    @monsterSprite5red = new createjs.Sprite(data, "right_idle")
    @monsterSprite5red.framerate = 10

    data = new createjs.SpriteSheet(
      images: [@loader.getResult("bloodPool")]
      frames:
        regX: 0
        height: 130
        count: 1
        regY: 0
        width: 130

      animations:
        down: [0, 0, "down"]
        left: [0, 0, "left"]
        right: [0, 0, "right"]
        up: [0, 0, "up"]
        left_idle: [0, 0]
        right_idle: [0, 0]
        up_idle: [0, 0]
        down_idle: [0, 0]
    )

    @blood = data

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

    for i in [0..40] by 1

      playerPos =
        x: Math.random()*@canvas.width
        y: Math.random()*@canvas.height

      while 950 <= playerPos.x <= 1450
        playerPos.x = Math.random()*@canvas.width

      color = Math.floor(Math.random() * 5)
      switch color
        when 0
          monster = _.extend (new Monster(_.clone(@monsterSprite), _.clone(@monsterSpritered), @stage)), (new createjs.Container())
        when 1
          monster = _.extend (new Monster(_.clone(@monsterSprite2), _.clone(@monsterSprite2red), @stage)), (new createjs.Container())
        when 2
          monster = _.extend (new Monster(_.clone(@monsterSprite3), _.clone(@monsterSprite3red), @stage)), (new createjs.Container())
        when 3
          monster = _.extend (new Monster(_.clone(@monsterSprite4), _.clone(@monsterSprite4red), @stage)), (new createjs.Container())
        when 4
          monster = _.extend (new Monster(_.clone(@monsterSprite5), _.clone(@monsterSprite5red), @stage)), (new createjs.Container())

      monster.init(playerPos,@blood)
      @stage.addChild monster
      @monsters.push monster

    for npcData in _npcs
      #create the player
      npc = _.extend (new NPC(_.clone(@playerSprite), @stage)), (new createjs.Container())
      npc.init(npcData)
      @stage.addChild npc

      @npcs.push npc

    @stage.addChild @player

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

      if @keyInput.spaceHeld
        @player.punch()

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
    for i in [0..@monsters.length-1] by 1
      @monsters[i].tick()
    @stage.x = -@player.x + @canvas.width * .5  if @player.x > @canvas.width * .5
    @stage.y = -@player.y + @canvas.height * .5  if @player.y > @canvas.height * .5
    @stage.update event, @level

  # Open a dialog
  startDialog: (dialog) =>
    @IN_DIALOG = true
    @dialogManager.showDialog dialog

  endAction: () =>
    @IN_DIALOG = false
