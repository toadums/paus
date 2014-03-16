Character = require 'coffee/character'
NPC = require 'coffee/npc'
Level = require 'coffee/level'

module.exports = class Monster extends Character
  constructor: (sprite, @hitsprite, @stage) ->
    @regsprite = _.clone(sprite)
    super sprite
    @tickCount = 0
    @waitCount = 0

  init: (@pos) =>
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

  hit: (direction) =>
    #do hit here

  tick: (event, level) =>
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


    if(@tickCount % Math.floor(Math.random() * 50) is 0)
      @facing = Math.floor(Math.random() * 4)
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


    vel = {
      x: 0
      y: 0
    }

    switch @facing
      when 0 then vel.y -= 5
      when 1 then vel.y += 5
      when 2 then vel.x -= 5
      when 3 then vel.x += 5

    horizCollision = false
    vertCollision = false

    # Collision detection
    for child in @stage.children
      dir = {}
      if child instanceof NPC or (child.type is 'tile' and (child.hit))

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
      @x += vel.x
    if not vertCollision
      @y += vel.y
