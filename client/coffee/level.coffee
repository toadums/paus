Items = require 'coffee/data/items'

module.exports = class Level
  constructor: (@delegate) ->
    {
      @stage
      @itemClick
      @player
    } = @delegate

    @numDivs = 20
    @divs = [] # 2d array

    @currentDiv =
      x: 0
      y: 0

    @onScreen = []

    @mapData
    @tileset
    @init()

  checkDiv: () =>
    perDiv = @layerSize*96 / @numDivs

    x = @currentDiv.x = Math.floor(@stage.x*-1 / perDiv) % @numDivs
    y = @currentDiv.y = Math.floor(@stage.y*-1 / perDiv) % @numDivs

    # hide every container
    ## This needs to change in the future
    for i in [0...@numDivs]
      for j in [0...@numDivs]
        @divs[i][j].visible = false

    # Show every container currently on the screen
    for i in [0..Math.ceil(@stage.canvas.width/perDiv)]
      for j in [0..Math.ceil(@stage.canvas.height/perDiv)]
        if x + i < @numDivs and y + j < @numDivs
          @divs[x + i][y + j].visible = true


    # NEED TO REMOVE OLD DIV EVENTUALLY

  checkHitsAtPosition: (x, y) =>
    x = Math.floor(x/@mapData.tilesets[0].tilewidth)
    y = Math.floor(y/@mapData.tilesets[0].tileheight)

    for layer in @mapData.layers
      if layer.data[x + y * layer.width] isnt 0 and layer.properties.hit is 'true'
        return true

    false

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

    for i in [0...@numDivs]
      for j in [0...@numDivs]
        @stage.addChild @divs[i][j]

    @checkDiv @player.x, @player.y


  initLayer: (layerData, tilesetSheet, tilewidth, tileheight) =>
    perDiv = layerData.height / @numDivs

    @layerSize ?= layerData.height

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

          cellSprite.diagonalHeight = Math.sqrt(cellSprite.height*cellSprite.height + cellSprite.width*cellSprite.width)

          cellSprite.hit = if layerData.properties.hit is "true" then true else false
          cellSprite.type = 'tile'
          #@stage.addChild cellSprite

          if data - 1 in @tilepropsKeys
            cellSprite.on 'click', _.partial @itemClick, cellSprite, _
            type = cellSprite.type = @tileprops[(data - 1).toString()].type

            if (item = _.find Items, (i) -> i.type is type)?
              cellSprite.id = item.id

          @divs[Math.floor(x / perDiv) % @numDivs]  ?= []
          @divs[Math.floor(x / perDiv) % @numDivs][Math.floor(y / perDiv) % @numDivs] ?= new createjs.Container()
          @divs[Math.floor(x / perDiv) % @numDivs][Math.floor(y / perDiv) % @numDivs].addChild cellSprite

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
