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

    @currentQuest = null

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

  setQuest: (quest) =>
    @currentQuest = quest

  handleComplete: (event) =>

    # Coffeescript sugar. Creates a new class variable for each sprite in system/sprites
    _.each Sprites, (val, name) =>
      @[name] = val(@loader)

    @restart()

  #reset all game logic
  restart: =>
    #hide anything on stage
    @stage.removeAllChildren()
    #ensure stage is blank and add the ship
    @stage.clear()
    @level = new Level(@stage)
    @stage.x = -8000
    @stage.y = -9000

    playerPos =
      x: 8400
      y: 9300

    #create the player
    @player = _.extend (new Player @), (new createjs.Container())
    @player.init(playerPos)

    window.p = @player

    @keyInput.reset()

    for i in [0..0] by 1

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
      console.log npcData.sprite, @[npcData.sprite]
      npc = _.extend (new NPC @, _.clone(@[npcData.sprite])), (new createjs.Container())
      npc.init(npcData)
      @stage.addChild npc
      @npcs.push npc

    @stage.addChild @player

    #start game timer
    createjs.Ticker.addEventListener "tick", @tick  unless createjs.Ticker.hasEventListener("tick")

  tick: (event) =>
    keys = []

    if @currentQuest?.isComplete
      @currentQuest = null
      @stage.removeChild @questArrow
      @questArrow = null

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
        @player.accelerate []
        @player.checkActions @npcs

      if @keyInput.spaceHeld
        @player.punch()
        @keyInput.spaceHeld = false

      if @keyInput.iHeld
        @player.accelerate []
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

      else if @keyInput.escHeld
        @keyInput.escHeld = false
        @dialogManager.keyPress "esc"


    else
      if @keyInput.escHeld or @keyInput.iHeld
        @keyInput.iHeld = false
        @inventory.keyPress "esc"
      else if @keyInput.lfHeld
        @keyInput.lfHeld = false
        @inventory.keyPress "left"
      else if @keyInput.rtHeld
        @keyInput.rtHeld = false
        @inventory.keyPress "right"


    #call sub ticks
    @player.tick event, @level

    npc.tick(event, @level) for npc in @npcs

    for i in [0..@monsters.length-1] by 1
      @monsters[i].tick()
    @stage.x = -@player.x + @canvas.width * .5  if @player.x > @canvas.width * .5
    @stage.y = -@player.y + @canvas.height * .5  if @player.y > @canvas.height * .5

    @stage.update event, @level

    # Whenever the callstack is clear, re-calculate arrow position
    _.defer(
      (quest) =>
        return unless quest?
        return unless (partNPC = quest.markers[quest.state])?
        return unless (npc = _.find @npcs, (npc) => npc.id is partNPC.npc)?

        v =
          x: (npc.x + npc.width/2) - (@player.x + @player.width/2)
          y: (npc.y + npc.height/2) - (@player.y + @player.height/2)

        len = Math.sqrt(v.x*v.x + v.y*v.y)

        if len > 200
          v.x /= len
          v.y /= len

          v.x *= 200
          v.y *= 200

        angle = Math.atan2(v.y, v.x) * 180 / Math.PI

        v.x += (@player.x + @player.width/2)
        v.y += (@player.y + @player.height/2)

        if @questArrow
          @stage.removeChild @questArrow

        @questArrow = _.clone(@arrowSprite)
        @questArrow.snapToPixel = true
        @questArrow.x = v.x
        @questArrow.y = v.y
        @questArrow.rotation = angle
        @stage.addChild @questArrow


      @currentQuest
    )

  # Open a dialog
  startDialog: (dialog) =>
    @IN_DIALOG = true
    @dialogManager.showDialog dialog

  endAction: () =>
    @IN_DIALOG = false

  endInventory: () =>
    @IN_INVENTORY = false
