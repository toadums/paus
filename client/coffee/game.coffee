KeyInput = require('coffee/input')
Player   = require('coffee/player')
Monster   = require('coffee/monster')
Level   = require('coffee/level')
NPC   = require('coffee/npc')
{DialogManager} = require('coffee/dialog')
Inventory = require('coffee/inventory')
_npcs = require 'coffee/data/npcs'
Manifest = require 'coffee/data/manifest'
Sprites = require 'coffee/system/sprites'
Collections = require 'coffee/collections'

module.exports = class Game
  constructor: () ->
    # If the player is in an action, they can't do anything
    @IN_ACTION = false
    @IN_INVENTORY = false

    @npcs = []
    @monsters = []

    @keyInput = new KeyInput
    @init()

  init: () =>
    @canvas = document.getElementById("gameCanvas")
    @stage = new createjs.Stage(@canvas)
    @dialogManager = new DialogManager @
    @inventory = new Inventory @

    manifest = Manifest or []
    @loader = new createjs.LoadQueue(false)
    @loader.addEventListener "complete", @handleComplete
    @loader.loadManifest manifest

    @stage.update() #update the stage to show text

  handleClick: =>
    @canvas.onclick = null

  handleComplete: (event) =>

    # Coffeescript sugar. Creates a new class variable for each sprite in system/sprites
    _.each Sprites, (val, name) =>
      @[name] = val(@loader)

    @restart()

  #reset all game logic
  restart: =>
    #hide anything on stage
    @stage.removeAllChildren()

    playerPos =
      x: @canvas.width/2 - 200
      y: @canvas.height/2 + 200

    #create the player
    @player = _.extend (new Player @), (new createjs.Container())
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
          monster = _.extend (new Monster(_.clone(@monsterSprite), _.clone(@monsterRedSprite), @stage)), (new createjs.Container())
        when 1
          monster = _.extend (new Monster(_.clone(@monster2Sprite), _.clone(@monsterRed2Sprite), @stage)), (new createjs.Container())
        when 2
          monster = _.extend (new Monster(_.clone(@monster3Sprite), _.clone(@monsterRed3Sprite), @stage)), (new createjs.Container())
        when 3
          monster = _.extend (new Monster(_.clone(@monster4Sprite), _.clone(@monsterRed4Sprite), @stage)), (new createjs.Container())
        when 4
          monster = _.extend (new Monster(_.clone(@monster5Sprite), _.clone(@monsterRed5Sprite), @stage)), (new createjs.Container())

      monster.init(playerPos,@bloodSprite)
      @stage.addChild monster
      @monsters.push monster

    for npcData in _npcs
      #create the player
      npc = _.extend (new NPC @), (new createjs.Container())
      npc.init(npcData)
      @stage.addChild npc
      @npcs.push npc

    @stage.addChild @player

    #start game timer
    createjs.Ticker.addEventListener "tick", @tick  unless createjs.Ticker.hasEventListener("tick")

  tick: (event) =>
    keys = []


    # If the user is 'doing something' dont let them do anything else..
    if not @IN_DIALOG and not @IN_INVENTORY
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

      if @keyInput.iHeld
        @IN_INVENTORY = true
        @keyInput.iHeld = false
        @inventory.showInventory()

    else if not @IN_INVENTORY
      if @keyInput.lfHeld
        @dialogManager.keyPress "left"
        @keyInput.lfHeld = false

      else if @keyInput.rtHeld
        @dialogManager.keyPress "right"
        @keyInput.rtHeld = false

      if @keyInput.enterHeld
        @dialogManager.keyPress "enter"
        @keyInput.enterHeld = false
    else
      if @keyInput.escHeld or @keyInput.iHeld
        @keyInput.iHeld = false
        @inventory.keyPress "esc"

    #call sub ticks
    @player.tick event, @level

    npc.tick(event, @level) for npc in @npcs

    for i in [0..@monsters.length-1] by 1
      @monsters[i].tick()
    @stage.x = -@player.x + @canvas.width * .5  if @player.x > @canvas.width * .5
    @stage.y = -@player.y + @canvas.height * .5  if @player.y > @canvas.height * .5
    @stage.update event, @level

    _.defer(
      (quest) =>
        quest = Collections.findModel quest
        partNPC = quest.markers[quest.state]
        npc = _.find @npcs, (npc) =>
          npc.id is partNPC.npc

        v =
          x: npc.x - @player.x
          y: npc.y - @player.y

        len = Math.sqrt(v.x*v.x + v.y*v.y)

        v.x /= len
        v.y /= len

        v.x *= 300
        v.y *= 300

        v.x += (@stage.x*-1 + @canvas.width / 2)
        v.y += (@stage.y*-1 + @canvas.height / 2)

        if @box?
          @stage.removeChild @box

        @box = new createjs.Shape()
        @box.graphics.beginStroke("#000")
        @box.graphics.beginFill("#51D9FF")
        @box.graphics.setStrokeStyle(2)
        @box.snapToPixel = true
        @box.graphics.drawRect(v.x, v.y, 20, 20)
        @stage.addChild @box



      900
    )

  # Open a dialog
  startDialog: (dialog) =>
    @IN_DIALOG = true
    @dialogManager.showDialog dialog

  endAction: () =>
    @IN_DIALOG = false

  endInventory: () =>
    @IN_INVENTORY = false
