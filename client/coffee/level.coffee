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


    for i in [0...@numDivs]
      for j in [0...@numDivs]
        @divs[i][j].visible = false

    for i in [0..Math.ceil(@stage.canvas.width/perDiv)]
      for j in [0..Math.ceil(@stage.canvas.height/perDiv)]
        if x + i < @numDivs and y + j < @numDivs
          @divs[x + i][y + j].visible = true


    # NEED TO REMOVE OLD DIV EVENTUALLY

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

          cellSprite.hit = if layerData.properties.hit is "true" then true else false
          cellSprite.type = 'tile'
          #@stage.addChild cellSprite

          if data - 1 in @tilepropsKeys
            cellSprite.on 'click', _.partial @itemClick, cellSprite
            cellSprite.type = @tileprops[(data - 1).toString()].type
            cellSprite.id = 352

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
