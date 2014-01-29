module.exports = class Character
  constructor: (sprite) ->

    @playerBody = sprite

  init: (pos) =>

    @addChild @playerBody

    @x = pos.x
    @y = pos.y

    @width = 165
    @height = 292
