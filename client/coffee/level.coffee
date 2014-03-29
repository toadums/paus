module.exports = class Level
  constructor: (@delegate) ->
    {
      @stage
      @itemClick
    } = @delegate

    @mapData
    @tileset
    @init()

  initLayers: () =>
    @level = new createjs.Container()
    w = @mapData.tilesets[0].tilewidth
    h = @mapData.tilesets[0].tileheight
    imageData =
      images: [@tileset]
      frames:
        width: w
        height: h

    # create spritesheet
    tilesetSheet = new createjs.SpriteSheet(imageData)

    # loading each layer at a time
    idx = 0

    while idx < @mapData.layers.length
      layerData = @mapData.layers[idx]
      @initLayer layerData, tilesetSheet, @mapData.tilewidth, @mapData.tileheight if layerData.type is "tilelayer"
      idx++

  initLayer: (layerData, tilesetSheet, tilewidth, tileheight) =>
    y = 0

    while y < layerData.height
      x = 0

      while x < layerData.width

        # create a new Sprite for each cell
        cellSprite = new createjs.Sprite(tilesetSheet)

        idx = x + y * layerData.width

        if (data = layerData.data[idx]) isnt 0


          cellSprite.gotoAndStop data - 1

          cellSprite.x = x * tilewidth
          cellSprite.y = y * tileheight
          cellSprite.num = layerData.name

          cellSprite.height = 96
          cellSprite.width = 96

          cellSprite.hit = if layerData.properties.hit is "true" then true else false
          cellSprite.type = 'tile'
          @stage.addChild cellSprite

          if data - 1 in @tilepropsKeys
            cellSprite.on 'click', _.partial @itemClick, cellSprite
            cellSprite.type = @tileprops[(data - 1).toString()].type
            cellSprite.id = 352

        x++
      y++

  init: (sprite) =>
    $.ajax
      url: "images/Level1.json"
      async: false
      dataType: "json"
      success: (response) =>
        @tileprops =  response.tilesets[0].tileproperties
        @tilepropsKeys = (parseInt(key) for key, value of @tileprops)
        @mapData = response
        @tileset = new Image()
        @tileset.src = @mapData.tilesets[0].image
        @tileset.onLoad = @initLayers()


  # @collide: (them, tile) ->
  #   return {} unless tile.hit is "true"
  #   top = tile.y
  #   left = tile.x
  #   right = tile.x + tile.spriteSheet._frameWidth
  #   bottom = tile.y + tile.spriteSheet._frameHeight

  #   collision =
  #     whore: false
  #     green: false

  #   if them.right >= left and (top <= them.top <= bottom or top <= them.bottom <= bottom) and not (them.left >= right)
  #     collision.whore = true
  #   if them.top <= bottom and (left <= them.left <= right or left <= them.right <= right) and not (them.bottom <= top)
  #     collision.green = true

  #   collision
