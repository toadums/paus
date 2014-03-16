NPC = require 'coffee/npc'
Monster = require 'coffee/monster'
Character = require 'coffee/character'
Level = require 'coffee/level'
Collections = require 'coffee/collections'

module.exports = class Player extends Character
  constructor: (sprite, @stage, @delegate) ->
    {
      @startDialog
    } = @delegate

    super sprite

    @MAX_VELOCITY = 20
    @lastKey

  init: (pos) =>
    super pos

    @vX = 0
    @vY = 0
    @facing = 3 #0 - up, 1 - down, 2 - left, 3 - right

  tick: (event, level) =>

    horizCollision = false
    vertCollision = false

    vel = {
      x: @vX
      y: @vY
    }

    # Collision detection
    for child in @stage.children
      dir = {}
      if child instanceof NPC or child instanceof Monster or (child.type is 'tile' and (child.hit))

        data =
          top: child.y
          left: child.x
          right: child.x + child.width
          bottom: child.y + child.height
        dir = @collide data, vel

      if dir.whore
        horizCollision = true
      if dir.green
        vertCollision = true

    if not horizCollision
      @x += @vX
    if not vertCollision
      @y += @vY

  punch: () =>

    vel = {
      x: @vX
      y: @vY
    }

    # Collision detection
    for child in @stage.children
      do (child) =>
        dir = {}
        if child instanceof NPC or child instanceof Monster or (child.type is 'tile' and (child.hit))
          data =
            top: child.y
            left: child.x
            right: child.x + child.width
            bottom: child.y + child.height
          dir = @collide data, vel

          if child instanceof Monster

            if dir.green or dir.whore
              if @facing == 1
                #punch down
                child.y += 80
              else if @facing == 0
                child.y -= 80
                #punch up
              else if @facing == 3
                child.x += 80
                #punch right
              else if @facing == 2
                child.x -= 80
                #punch left
              child.playerBody.spriteSheet = child.hitsprite.spriteSheet

              revertSprite = () ->

                child.playerBody.spriteSheet = child.regsprite.spriteSheet

              setTimeout revertSprite, 100



  # If the player is holding the E key, and the character is within 300px from an NPC,
  # play that NPCs dialog
  checkActions: (npcs) =>
    # We are going from the CENTERS of the characters
    me =
      x: @x + @width/2
      y: @y + @height/2

    for npc in npcs
      them =
        x: npc.x + npc.width/2
        y: npc.y + npc.height/2

      # Vector from me to them
      v =
        x: me.x - them.x
        y: me.y - them.y

      # Distance between centers
      d = Math.sqrt(v.x*v.x + v.y*v.y)

      if d < 300 # Random number
        if (dialog = npc.getDialog())
          @startDialog npc.getDialog()


  accelerate: (keys) =>
    @vX = 0
    @vY = 0
    latestKey = false

    keys.forEach (key) =>
      @vX += -@MAX_VELOCITY if key is "left"
      @vX += @MAX_VELOCITY if key is "right"
      @vY += -@MAX_VELOCITY if key is "up"
      @vY += @MAX_VELOCITY if key is "down"
      latestKey = key

    switch latestKey
      when "left"
        @facing = 2
        if @playerBody.currentAnimation isnt "left"
          @playerBody.gotoAndPlay "left"
          @lastKey = "left"
      when "right"
        @facing = 3
        if @playerBody.currentAnimation isnt "right"
          @playerBody.gotoAndPlay "right"
          @lastKey = "right"
      when "up"
        @facing = 0
        if @playerBody.currentAnimation isnt "up"
          @playerBody.gotoAndPlay "up"
          @lastKey = "up"
      when "down"
        @facing = 1
        if @playerBody.currentAnimation isnt "down"
          @playerBody.gotoAndPlay "down"
          @lastKey = "down"
      else
        switch @lastKey
          when "left"
            @playerBody.gotoAndPlay "left_idle"
          when "up"
            @playerBody.gotoAndPlay "up_idle"
          when "down"
            @playerBody.gotoAndPlay "down_idle"
          when "right"
            @playerBody.gotoAndPlay "right_idle"
          else
    @vX = @MAX_VELOCITY  if @vX > @MAX_VELOCITY
    @vX = -@MAX_VELOCITY  if @vX < -@MAX_VELOCITY
    @vY = @MAX_VELOCITY  if @vY > @MAX_VELOCITY
    @vY = -@MAX_VELOCITY  if @vY < -@MAX_VELOCITY
