Character = require 'coffee/character'
NPC = require 'coffee/npc'
Level = require 'coffee/level'

module.exports = class Monster extends Character
  constructor: (sprite, @hitsprite, @delegate) ->
    {
      @stage
      @monsterClick
      @player
      @isSoundOn
    } = @delegate

    @regsprite = _.clone(sprite)
    super @regsprite
    @tickCount = 0
    @waitCount = 0
    @dying = false
    @MAX_VELOCITY = 20


  init: (@pos,blood) =>
    @bloodSprite = blood
    super @pos
    @facing = Math.floor(Math.random() * 4) #0 - up, 1 - down, 2 - left, 3 - right
    switch @facing
      when 0
        if @playerBody.currentAnimation isnt "up"
          @playerBody.gotoAndPlay "up"
      when 1
        if @playerBody.currentAnimation isnt "down"
          @playerBody.gotoAndPlay "down"
      when 2
        if @playerBody.currentAnimation isnt "left"
          @playerBody.gotoAndPlay "left"
      when 3
        if @playerBody.currentAnimation isnt "right"
          @playerBody.gotoAndPlay "right"
    @life = 2

    @on 'click', _.partial @monsterClick, @, _
    @diagonalHeight = Math.sqrt((@width/2)*(@width/2) + (@height/2)*(@height/2))
  hit: (direction) =>
    #do hit here

  kill: () =>
    killChild = () =>
      @stage.removeChild this
    setTimeout killChild, 4000
    if @isSoundOn()
      createjs.Sound.play "splat"

    @playerBody.spriteSheet = _.clone(@bloodSprite)
    @playerBody.gotoAndPlay "left_idle"

  lineDistance: (point1, point2) =>
    xs = 0
    ys = 0

    xs = point2.x - point1.x
    xs = xs * xs

    ys = point2.y - point1.y
    ys = ys * ys

    return Math.sqrt( xs + ys )


  # are the center points of the player and bunny within 100 of eachother?
  checkDamagePlayer: =>
    v =
      x: (@player.x + @player.width / 2) - (@x + @width / 2)
      y: (@player.y + @player.height / 2) - (@y + @height / 2)

    d = Math.sqrt(v.x*v.x + v.y*v.y)

    if d < 125
      @player.damage()

  tick: (event, level) =>

    # Ignore bunnies that are off screen
    if not (-@stage.x - 200 <= @x <= -@stage.x + @stage.canvas.width + 200 and -@stage.y - 200 <= @y <= -@stage.y + @stage.canvas.height + 200)
      @visible = false
      return
    else if not @visible
      @visible = true

    if @dying
      @playerBody.spriteSheet = @bloodSprite
      return false

    @checkDamagePlayer()

    @tickCount++

    if @waitCount > 0
      @waitCount -= 1
      if @waitCount isnt 0
        return;
      else
        switch @facing
          when 0
            @playerBody.gotoAndPlay "up"
          when 1
            @playerBody.gotoAndPlay "down"
          when 2
            @playerBody.gotoAndPlay "left"
          when 3
            @playerBody.gotoAndPlay "right"


    if(@tickCount % Math.floor(Math.random() * 300) is 0)
      @waitCount = 20
      switch @facing
        when 0
          @playerBody.gotoAndPlay "up_idle"
        when 1
          @playerBody.gotoAndPlay "down_idle"
        when 2
          @playerBody.gotoAndPlay "left_idle"
        when 3
          @playerBody.gotoAndPlay "right_idle"

    randomDirArr = []

    if @player.x > @x
      randomDirArr.push 3
    else
      randomDirArr.push 2

    if @player.y > @y
      randomDirArr.push 1
    else
      randomDirArr.push 0


    if(@tickCount % Math.floor(Math.random() * 50) is 0)
      if (@lineDistance {x:@player.x, y:@player.y}, {x:@x,y:@y}) > 2500
        @facing = Math.floor(Math.random() * 4)
      else
        @facing = randomDirArr[Math.floor(Math.random()*randomDirArr.length)]

      switch @facing
        when 0
          if @playerBody.currentAnimation? isnt "up"
            @playerBody.gotoAndPlay "up"
        when 1
          if @playerBody.currentAnimation? isnt "down"
            @playerBody.gotoAndPlay "down"
        when 2
          if @playerBody.currentAnimation? isnt "left"
            @playerBody.gotoAndPlay "left"
        when 3
          if @playerBody.currentAnimation? isnt "right"
            @playerBody.gotoAndPlay "right"


    horizCollision = false
    vertCollision = false



    # Collision detection
    for child in @stage.children

      dir = @checkCollisions(child) or {}

      if dir.whore
        horizCollision = true
      if dir.green
        vertCollision = true

    if not horizCollision
      @x += @velocity().x
    if not vertCollision
      @y += @velocity().y

  velocity: () =>
    vel = {
      x: 0
      y: 0
    }

    switch @facing
      when 0 then vel.y -= 5
      when 1 then vel.y += 5
      when 2 then vel.x -= 5
      when 3 then vel.x += 5

    vel

  checkCollision: (child) =>
    dir = {}
    if child instanceof NPC or (child.type is 'tile' and (child.hit))

      data =
        top: child.y
        left: child.x
        right: child.x + child.width
        bottom: child.y + child.height
        width: child.width
        height: child.height
        diagonalHeight: child.diagonalHeight
      dir = @collide data, @velocity()

    return dir
