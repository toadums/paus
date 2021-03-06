Intro = require('coffee/intro')
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
Map = require 'coffee/map'
Home = require 'coffee/home'
Instructions = require 'coffee/instructions'
Win = require 'coffee/win'

module.exports = class Game
  constructor: () ->
    # If the player is in an action, they can't do anything
    @IN_ACTION = false
    @IN_INVENTORY = false
    @MAP_OPEN = false
    @INTRO = false
    @HOME = true
    @INSTR = false
    @WIN = false

    @GAME_OVER = false

    @npcs = []
    @monsters = []
    @keyInput = new KeyInput
    @init()

    @currentQuest = null
    @healthBar = null

    @itemsInteractedWith = []
    @charsInteractedWith = []
    @monstersInteractedWith = []

  clearModes: =>
    @INTRO = false
    @HOME = false
    @INSTR = false
    @GAME_OVER = false
    @WIN = false

  addLoadingText: () =>
    @stage.x = 0
    @stage.y = 0

    loadingText = "Loading...hold tight, this may take a hare"

    ctx = @stage.canvas.getContext('2d')
    ctx.font = "40px Arial"

    x = @stage.canvas.width/2 - ctx.measureText(loadingText).width/2

    @loadingText = new createjs.Text loadingText, "40px Arial", "white"
    @loadingText.x = x
    @loadingText.y = @stage.canvas.height/2 - 100
    @loadingText.snapToPixel = true
    @loadingText.textBaseline = "alphabetic"

    @stage.addChild @loadingText
    @stage.update()


  init: () =>
    @canvas = document.getElementById("gameCanvas")
    @canvas.onselectstart = () -> false
    @stage = new createjs.Stage(@canvas)

    @addLoadingText()

    @img = document.createElement('img')
    @img.src = '/images/map.png';


    @dialogManager = new DialogManager @
    @inventory = new Inventory @
    @map = new Map @stage, @img
    manifest = Manifest or []
    @loader = new createjs.LoadQueue(false)
    @loader.installPlugin createjs.Sound
    @loader.addEventListener "complete", @handleComplete
    @loader.loadManifest manifest

    @intro = new Intro @
    @home = new Home @
    @instructions = new Instructions @
    @win = new Win @

    @stage.update() #update the stage to show text
    @soundOn = true

  handleClick: =>
    @canvas.onclick = null

  setQuest: (quest) =>
    @currentQuest = quest

  handleComplete: (event) =>

    # Coffeescript sugar. Creates a new class variable for each sprite in system/sprites
    _.each Sprites, (val, name) =>
      if name isnt 'blankSprite'
        @[name] = val(@loader)

    @stage.removeChild @loadingText

    #start game timer
    createjs.Ticker.addEventListener "tick", @tick  unless createjs.Ticker.hasEventListener("tick")

    if @isSoundOn()
      createjs.Sound.play 'music', createjs.Sound.INTERRUPT_NONE, 0, 0, true, 1

  spawnMonsters: (diff)=>

    num = if diff is 1 then 1200 else 800

    # 1000 spawns around 600 bunnies
    for i in [0..num] by 1

      playerPos =
        x: Math.random() * 9200
        y: Math.random() * 9200

      if @level.checkHitsAtPosition playerPos.x, playerPos.y
        continue

      color = Math.floor(Math.random() * 5)
      switch color
        when 0
          monster = _.extend (new Monster(_.clone(@monsterSprite), _.clone(@monsterRedSprite), @)), (new createjs.Container())
        when 1
          monster = _.extend (new Monster(_.clone(@monster2Sprite), _.clone(@monsterRed2Sprite), @)), (new createjs.Container())
        when 2
          monster = _.extend (new Monster(_.clone(@monster3Sprite), _.clone(@monsterRed3Sprite), @)), (new createjs.Container())
        when 3
          monster = _.extend (new Monster(_.clone(@monster4Sprite), _.clone(@monsterRed4Sprite), @)), (new createjs.Container())
        when 4
          monster = _.extend (new Monster(_.clone(@monster5Sprite), _.clone(@monsterRed5Sprite), @)), (new createjs.Container())

      monster.init(playerPos,@bloodSprite)
      @stage.addChild monster
      @monsters.push monster

  toggleSound: =>
    if @soundOn
      createjs.Sound.stop 'music', createjs.Sound.INTERRUPT_NONE, 0, 0, true, 1
      @soundOn = false
    else
      createjs.Sound.play 'music', createjs.Sound.INTERRUPT_NONE, 0, 0, true, 1
      @soundOn = true

  isSoundOn: =>
    @soundOn

  #reset all game logic
  restart: =>

    if @isSoundOn()
      createjs.Sound.stop 'music', createjs.Sound.INTERRUPT_NONE, 0, 0, true, 1
      createjs.Sound.play 'music', createjs.Sound.INTERRUPT_NONE, 0, 0, true, 1


    Collections.reset()
    #hide anything on stage
    @stage.removeAllChildren()
    Inventory.items = []
    #ensure stage is blank and add the ship
    @stage.clear()
    @stage.x = -(9600 - @stage.canvas.width)
    @stage.y = -(9600 - @stage.canvas.height)

    @npcs = []
    @monsters = []

    if not @player
      #create the player
      @player = _.extend (new Player @), (new createjs.Container())
      @player.init()
      window.p = @player


    playerPos =
      x: 8400
      y: 9300

    @player.restart(playerPos)

    @level = new Level @

    @keyInput.reset()

    #@stage.on 'click', @player.goto

    @spawnMonsters(@difficulty)
    for npcData in _npcs

      # if no sprite specified, just use the generic player.
      # if the sprite is blank, make a blank sprite based on size
      # else actually create the sprite they want

      if not npcData.sprite?
        sprite = _.clone @playerSprite
      else if npcData.sprite is 'blank'
        sprite = _.clone Sprites.blankSprite(@loader, npcData.size.x, npcData.size.y)
      else
        sprite = _.clone(@[npcData.sprite])

      npc = _.extend (new NPC @, sprite), (new createjs.Container())

      npc.init(npcData)

      @stage.addChild npc
      @npcs.push npc

    @stage.addChild @player

    @healthBar = new createjs.Shape()
    @healthBar.graphics.beginStroke("#000")
    @healthBar.graphics.beginFill("rgb(0,255,0)")
    @healthBar.graphics.setStrokeStyle(2)
    @healthBar.snapToPixel = true
    @healthBar.graphics.drawRect(@player.x-70, @player.y-65, 150*(@player.health / @player.healthMax), 15)
    @healthBar.visible = true
    @stage.addChild @healthBar


    switch @difficulty
      when 1
        @player.health = 10
        @player.healthMax = 10
        for monster in @monsters
          monster.life = 5
          monster.MAX_VELOCITY = 8
        @player.knockback = false



      when 666
        @player.health = 1
        @player.healthMax = 1
        for monster in @monsters
          monster.life = 5
          monster.MAX_VELOCITY = 5
        @player.knockback = false


      else
        @player.health = 15
        @player.healthMax = 15
        for monster in @monsters
          monster.life = 2
          monster.MAX_VELOCITY = 5
        @player.knockback = true

  itemClick: (item, data, ev) =>
    @itemsInteractedWith.push item
    @objectClick ev

  characterClick: (char, data, ev) =>
    @charsInteractedWith.push char
    @objectClick ev

  monsterClick: (monster, data, ev) =>
    @monstersInteractedWith.push monster
    @objectClick ev

  objectClick: (ev) =>
    @player.gotoPos = null
    ev.stopPropagation()

  tick: (event) =>

    if @WIN
      if not @win.visible
        @win.show()

      @win.tick event

      return

    if @HOME
      if not @home.visible
        @home.show()

      @stage.x = 0
      @stage.y = 0

      @home.tick event

      return

    if @INSTR
      if not @instructions.visible
        @instructions.show()

      @stage.x = 0
      @stage.y = 0

      @instructions.tick event

      return

    if @INTRO
      if not @intro.visible
        @intro.show()

      @stage.x = 0
      @stage.y = 0

      @intro.tick event
      if @keyInput.escHeld
        @restart()
        @INTRO = false

      return

    # Game over. Clear the stage and show the message set in @GAME_OVER
    if @GAME_OVER

      if @keyInput.escHeld
        @stage.removeAllChildren()
        @showHome()

      if @GAME_OVER and @GAME_OVER isnt 'fin'
        @stage.update()

        @stage.x = 0
        @stage.y = 0

        text = new createjs.Text(@GAME_OVER, "26px Arial", "white")

        ctx = @stage.canvas.getContext('2d')
        ctx.font = "26px Arial"

        x = @stage.canvas.width/2 - ctx.measureText(@GAME_OVER).width/2

        text.x = x
        text.y = @stage.canvas.height/2 - 100
        text.snapToPixel = true
        text.textBaseline = "alphabetic"

        esc = new createjs.Text("(esc to go back)", "14px Arial", "white")
        esc.x = x
        esc.y = @stage.canvas.height/2
        esc.snapToPixel = true
        esc.textBaseline = "alphabetic"


        @stage.addChild text
        @stage.addChild esc
        @stage.update()
        # Don't want to re-add things to the stage
        @GAME_OVER = "fin"
      return

    keys = []

    return unless @player?

    if @currentQuest?.isComplete
      @currentQuest = null
      @stage.removeChild @questArrow
      @questArrow = null

    if (item = (@itemsInteractedWith.splice 0, 1)[0])? and @player.checkDistance(item, 200)
      Inventory.items.push item.id
      @inventory.refresh()
      @stage.removeChild item
      item.visible = false

    if (char = (@charsInteractedWith.splice 0, 1)[0])? and @player.checkDistance(char, 300)
      if (dialog = char.getDialog())?
        @startDialog dialog

    if (monster = (@monstersInteractedWith.splice 0, 1)[0])? and @player.checkDistance(monster, 300)
      @player.damageBunny monster

    if @keyInput.bHeld and _.contains Inventory.items, 666
      @showWin()

    # If the user is 'doing something' dont let them do anything else..
    if not @IN_DIALOG and not @IN_INVENTORY
      #handle thrust
      keys.push "up"  if @keyInput.fwdHeld
      keys.push "down"  if @keyInput.dnHeld
      keys.push "left"  if @keyInput.lfHeld
      keys.push "right"  if @keyInput.rtHeld

      moving = @player.accelerate keys

      if moving
        @level.checkDiv()

      if @keyInput.spaceHeld
        @keyInput.spaceHeld = false
        @player.punch()


      if @keyInput.iHeld
        @player.accelerate []
        @IN_INVENTORY = true
        @keyInput.iHeld = false
        @inventory.showInventory()

      if @keyInput.actionHeld
        @player.accelerate []
        if not @player.checkNPCActions @npcs
          if (item = @player.checkItemAcions @level.items)?
            Inventory.items.push item.id
            @inventory.refresh()
            @stage.removeChild item
            item.visible = false

        @keyInput.actionHeld = false

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

    # Displaying the map should be done independently of everything else, as it is just a hold-to-show thing.
    # You want to be able to see the map while moving
    if @keyInput.mHeld and not @MAP_OPEN
      # Open a closed map
      @MAP_OPEN = true
      @map.update @stage, @player.x, @player.y, false

    else if @MAP_OPEN and not @keyInput.mHeld
      # Close an open map
      @MAP_OPEN = false
      @map.close()

    else if @MAP_OPEN and @keyInput.mHeld and moving
      # Show a transparent map while moving (close old map first)
      @map.close()
      @map.update @stage, @player.x, @player.y, true

    @healthBar.graphics.clear()
    @healthBar.graphics.beginStroke("#000")
    @healthBar.graphics.beginFill("rgb("+(255 - Math.floor(((@player.health / @player.healthMax)*255))) + ","+Math.floor(((@player.health / @player.healthMax)*255))+",0)")
    @healthBar.graphics.setStrokeStyle(2)
    @healthBar.snapToPixel = true
    @healthBar.graphics.drawRect(@player.x + (150 - (150*(@player.health / @player.healthMax))) / 2 , @player.y, 150*(@player.health / @player.healthMax), 15)

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
    @player.gotoPos = null
    @IN_DIALOG = false

  endInventory: () =>
    @IN_INVENTORY = false

  gameover: (msg) =>
    @GAME_OVER = msg

  startGame: (diff) =>
    @clearModes()
    @stage.removeAllChildren()
    @difficulty = diff or 0
    @INTRO = true

  showHome: =>
    @clearModes()
    @stage.removeAllChildren()

    @HOME = true

  showInstructions: =>
    @clearModes()
    @stage.removeAllChildren()

    @INSTR = true

  showWin: =>
    @clearModes()
    @stage.removeAllChildren()

    @WIN = true
