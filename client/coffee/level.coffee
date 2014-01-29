module.exports = class Level
  constructor: (@stage) ->
    @init()
    @mapData
    @tileset

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
    console.log layerData
    while y < layerData.height
      x = 0

      while x < layerData.width

        # create a new Sprite for each cell
        cellSprite = new createjs.Sprite(tilesetSheet)

        idx = x + y * layerData.width

        if layerData.data[idx] isnt 0
          cellSprite.gotoAndStop layerData.data[idx] - 1

          cellSprite.x = x * tilewidth
          cellSprite.y = y * tileheight
          cellSprite.num = layerData.name

          cellSprite.hit = layerData.properties.hit
          cellSprite.type = 'tile'

          @stage.addChild cellSprite
        x++
      y++

  init: (sprite) =>
    $.ajax
      url: "images/Level1.json"
      async: false
      dataType: "json"
      success: (response) =>
        @mapData = response
        @tileset = new Image()
        @tileset.src = @mapData.tilesets[0].image
        @tileset.onLoad = @initLayers()


