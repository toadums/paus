module.exports = class Player
  constructor: (@sprite, @stage) ->

    @MAX_VELOCITY = 20
    @lastKey
    @player
    @playerBody

  init: () =>

    @playerBody = @sprite

    @addChild @playerBody

    @vX = 0
    @vY = 0

  tick: (event, level) =>
    @x += @vX
    @y += @vY

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

    if latestKey isnt false
      @playerBody.gotoAndPlay "run"  if @playerBody.currentAnimation isnt "run"
    else
      @playerBody.gotoAndPlay "idle"
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
