NPC = require 'coffee/npc'
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

  tick: (event, level) =>
    @x += @vX
    @y += @vY

    data =
      top: @y
      left: @x
      right: @x + @width
      bottom: @y + @height

    # Collision detection
    for child in @stage.children
      dir = {}
      if child instanceof NPC
        dir = child.collide data
      else if child.type is 'tile'
        dir = Level.collide data, child

      if dir.whore then @x -= @vX
      if dir.green then @y -= @vY

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
        if (dialog = npc.dialog)
          @startDialog Collections.findModel(dialog)


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
        if @playerBody.currentAnimation isnt "left"
          @playerBody.gotoAndPlay "left"
          @lastKey = "left"
      when "right"
        if @playerBody.currentAnimation isnt "right"
          @playerBody.gotoAndPlay "right"
          @lastKey = "right"
      when "up"
        if @playerBody.currentAnimation isnt "up"
          @playerBody.gotoAndPlay "up"
          @lastKey = "up"
      when "down"
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
