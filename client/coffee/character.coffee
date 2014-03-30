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


    # Instead of doing a huge calculation of corners, just do a preliminary check to see if we are within the MAX distance we could be from eachother
    if Math.sqrt(v.x*v.x + v.y*v.y) <= @diagonalHeight + them.diagonalHeight

      # Horizontal collision detection. If the object ISNT to my top or bottom (its to my side), check to see if I collide
      if not (them.top <= top and them.bottom - @MAX_VELOCITY <= top) and not (them.bottom >= bottom and them.top + @MAX_VELOCITY >= bottom)
        # Check to make sure the object is on the correct side to me (ie. the side that my velocity is pointing at. This is the part before the 'and')
        # To see if I collide, make a vector from my left, to their right; and another from my right to their left. If either of these vectors go the opposite direction
        # from my velocity.x, then I know that my edge is INSIDE them, and I am trying to continue that direction...collide.
        if v.x * vel.x > 0 and (r * vel.x < 0 or l * vel.x < 0)
          collision.whore = true

      # Vertical collision detection. Same shit, different direction
      if not (them.left <= left and them.right - @MAX_VELOCITY <= left) and not (them.right >= right and them.left + @MAX_VELOCITY >= right)
        if v.y * vel.y > 0 and (t * vel.y < 0 or b * vel.y < 0)
          collision.green = true


    collision
