module.exports = class Character
  constructor: (sprite) ->

    @playerBody = sprite

  init: (pos) =>

    @addChild @playerBody

    @x = pos.x
    @y = pos.y

    @width = 165
    @height = 292

  collide: (them) ->
    top = @y
    left = @x
    right = @x + @playerBody.spriteSheet._frameWidth
    bottom = @y + @playerBody.spriteSheet._frameHeight

    collision =
      whore: false
      green: false

    if them.right > left and (top < them.top < bottom or top < them.bottom < bottom) and not (them.left > right)
      collision.whore = true
    if them.top < bottom and (left < them.left < right or left < them.right < right) and not (them.bottom < top)
      collision.green = true

    collision