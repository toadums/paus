NPC = require 'coffee/npc'
Monster = require 'coffee/monster'
Character = require 'coffee/character'
Level = require 'coffee/level'
Collections = require 'coffee/collections'

module.exports = class Player extends Character

  # Static inventory. Should be refactored at a later date
  constructor: (@delegate) ->
    {
      @startDialog
      playerSprite: sprite
      @stage
    } = @delegate

    super sprite

    @MAX_VELOCITY = 50
    @lastKey

  moveTo: (x, y) =>
    @x = x
    @y = y

  init: (pos) =>
    super pos

    @vX = 0
    @vY = 0
    @facing = 3 #0 - up, 1 - down, 2 - left, 3 - right
    @health = 10
    @recentlyHit = false

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
      if child instanceof NPC or (child instanceof Monster and child.dying is false) or (child.type is 'tile' and (child.hit))
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

      if (dir.whore or dir.green) and child instanceof Monster and not @recentlyHit
        @recentlyHit = true
        @health -= 1
        console.log @health
        setTimeout(
          () =>
            console.log 'here'
            @recentlyHit = false
          2000
        )

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
        if child instanceof Monster
          data =
            top: child.y
            left: child.x
            right: child.x + child.width
            bottom: child.y + child.height
          # dir = @collide data, vel

          if !child.dying

            if child instanceof Monster
              if (@lineDistance {x:child.x, y:child.y}, {x:@x,y:@y}) < 200 and child.life > 0
                if child.x > @x and @facing is 3
                  child.x += 80
                  @damageBunny child
                else if child.x < @x and @facing is 2
                  child.x -= 80
                  @damageBunny child
                else if child.y < @y and @facing is 0
                  child.y -= 80
                  @damageBunny child
                else if child.y > @y and @facing is 1
                  child.y += 80
                  @damageBunny child
            # if dir.green or dir.whore

            #     if @facing == 1
            #       #punch down
            #       child.y += 80
            #     else if @facing == 0
            #       child.y -= 80
            #       #punch up
            #     else if @facing == 3
            #       child.x += 80
            #       #punch right
            #     else if @facing == 2
            #       child.x -= 80
            #       #punch left

  # If the player is holding the E key, and the character is within 300px from an NPC,
  # play that NPCs dialog

  damageBunny: (child) =>
    child.life -= 1

    child.playerBody.spriteSheet = child.hitsprite.spriteSheet

    revertSprite = () ->
      child.playerBody.spriteSheet = child.regsprite.spriteSheet

    setTimeout revertSprite, 100

    if child.life <= 0
      child.dying = true
      child.kill()

  checkDistance: (item, max) =>
    me =
      x: @x + @width/2
      y: @y + @height/2

    them =
      x: item.x + item.width/2
      y: item.y + item.height/2

    # Vector from me to them
    v =
      x: me.x - them.x
      y: me.y - them.y


    # Distance between centers
    d = Math.sqrt(v.x*v.x + v.y*v.y)
    d < max # return true if d < 200 else false

  # Am I facing in the right direction to interact?
  isFacing: (them) =>
    v =
      x: @x - them.x
      y: @y - them.y
    angle = Math.abs(Math.atan(v.y/v.x) * 180 / Math.PI)
    (@facing is 3 and v.x < 0  and (0 < angle < 60)) or
      (@facing is 2 and v.x > 0 and (0 < angle < 60)) or
      (@facing is 0 and v.y > 0 and (60 < angle < 120)) or
      (@facing is 1 and v.y < 0 and (60 < angle < 120))

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

    # Was the guy moving?
    return true if @vX or @vY

  lineDistance: (point1, point2) =>
    xs = 0
    ys = 0

    xs = point2.x - point1.x
    xs = xs * xs

    ys = point2.y - point1.y
    ys = ys * ys

    return Math.sqrt( xs + ys )

  toClearihue: =>
    @x = 8000
    @y = 7000

  toStart: =>
    @x = 9000
    @y = 9000

  toCornett: =>
    @x = 8720
    @y = 4500

  toSSM: =>
    @x = 8500
    @y = 1800

  toElliot: =>
    @x = 1720
    @y = 6060

  toLib: =>
    @x = 3120
    @y = 8940

  pos: (x, y)=>
    if not (x? or y?)
      "x: #{@x}, y: #{@y}"
    else
      @x = x
      @y = y
