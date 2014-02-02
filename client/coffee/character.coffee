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

  collide: (them) ->
    top = @y
    left = @x
    right = @x + @width
    bottom = @y + @height

    collision =
      whore: false
      green: false

    if them.right >= left and (top <= them.top <= bottom or top <= them.bottom <= bottom) and not (them.left >= right)
      collision.whore = true
    if them.top <= bottom and (left <= them.left <= right or left <= them.right <= right) and not (them.bottom <= top)
      collision.green = true

    collision