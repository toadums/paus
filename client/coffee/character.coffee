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
    top = @y
    left = @x
    right = @x + @width
    bottom = @y + @height

    collision =
      whore: false
      green: false

    # if them.right >= left and (top <= them.top <= bottom or top <= them.bottom <= bottom) and not (them.left >= right) and not (top > them.bottom) and not (bottom < them.top)
    #   collision.whore = true
    # if them.top <= bottom and (left <= them.left <= right or left <= them.right <= right) and not (them.bottom <= top)
    #   collision.green = true

    if ((right >= them.left and right <= them.right) and (top >= them.top and top <= them.bottom)) or
      ((left >= them.left and left <= them.right) and (top >= them.top and top <= them.bottom)) or
      ((right >= them.left and right <= them.right) and (bottom >= them.top and bottom <= them.bottom)) or
      ((left >= them.left and left <= them.right) and (bottom >= them.top and bottom <= them.bottom)) or

      ((them.right >= left and them.right <= right) and (them.top >= top and them.top <= bottom)) or
      ((them.left >= left and them.left <= right) and (them.top >= top and them.top <= bottom)) or
      ((them.right >= left and them.right <= right) and (them.bottom >= top and them.bottom <= bottom)) or
      ((them.left >= left and them.left <= right) and (them.bottom >= top and them.bottom <= bottom))
        
        if right >= them.left and vel.x > 0 and left <= them.left
          collision.whore = true
        else if left <= them.right and vel.x < 0 and right >= them.right
          collision.whore = true

        if top <= them.bottom and vel.y < 0 and bottom >= them.bottom
          collision.green = true
        else if bottom >= them.top and vel.y > 0 and top <= them.top
          collision.green = true


    # if ((right >= them.left and right <= them.right) and (top >= them.top and top <= them.bottom))
    #   #right top corner inside
    #   if(vel.x > 0)
    #     collision.whore = true
    #   if(vel.y < 0)
    #     collision.green = true
    # else if((left >= them.left and left <= them.right) and (top >= them.top and top <= them.bottom))
    #   #left top corner inside
    #   if(vel.x < 0)
    #     collision.whore = true
    #   if(vel.y < 0)
    #     collision.green = true
    # else if((right >= them.left and right <= them.right) and (bottom >= them.top and bottom <= them.bottom))
    #   #bottom right corner inside
    #   if(vel.x > 0)
    #     collision.whore = true
    #   if(vel.y > 0)
    #     collision.green = true
    # else if((left >= them.left and left <= them.right) and (bottom >= them.top and bottom <= them.bottom))
    #   #bottom left corner inside
    #   if(vel.x < 0)
    #     collision.whore = true
    #   if(vel.y > 0)
    #     collision.green = true

    collision