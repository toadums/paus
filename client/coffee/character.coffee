module.exports = class Character
  constructor: (sprite) ->

    @playerBody = sprite
  init: (pos) =>
    @addChild @playerBody

    @x = pos.x
    @y = pos.y

    # Width of the sprite
    @width = @playerBody.spriteSheet._frameWidth
    @height = @playerBody.spriteSheet._frameHeight

  collide: (them, vel) ->
    top = @y + @height/2
    left = @x
    right = @x + @width
    bottom = @y + @height

    collision =
      whore: false
      green: false

    r = them.right - left
    l = them.left - right
    t = them.top - bottom
    b = them.bottom - top

    themCenter =
      x: them.left + (them.right-them.left) / 2
      y: them.top + (them.bottom-them.top) / 2

    meCenter =
      x: left + (@width/2)
      y: bottom - (@height/4)

    v =
      x: themCenter.x - meCenter.x
      y: themCenter.y - meCenter.y

    if Math.sqrt(v.x*v.x + v.y*v.y) <= @diagonalHeight + them.diagonalHeight

      if not (them.top <= top and them.bottom - @MAX_VELOCITY <= top) and not (them.bottom >= bottom and them.top + @MAX_VELOCITY >= bottom)
        if (r * vel.x < 0) and (v.x * vel.x > 0) or (l * vel.x < 0) and (v.x * vel.x > 0)
          collision.whore = true

      if not (them.left <= left and them.right - @MAX_VELOCITY <= left) and not (them.right >= right and them.left + @MAX_VELOCITY >= right)
        if (t * vel.y < 0) and (v.y * vel.y > 0) or (b * vel.y < 0) and (v.y * vel.y > 0)
          collision.green = true


    collision
