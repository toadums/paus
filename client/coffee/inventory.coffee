{ wrap } = require 'coffee/utils'
# Dialog class for dialogs. For right now just a yes/no box. We could make a 'done' box too
# WORK IN PROGRESS. We need to figure out a better way. use containers

module.exports = class Inventory
  @items = [300]
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endInventory
    } = @delegate

    @w = 428
    @h = 208
    @shownItems = []
    @lines = []
    @selected = 0
    @open = false

  # Draw the box that holds the dialog
  createBox: =>
    @box = new createjs.Shape()
    @box.graphics.beginStroke("#000")
    @box.graphics.beginFill("papayawhip")
    @box.graphics.setStrokeStyle(2)
    @box.snapToPixel = true
    @box.graphics.drawRect(@pos.x, @pos.y, @w, @h)
    @stage.addChild @box


  createText: =>
    return if @shownItems.length is 0
    # Add the name
    @stage.removeChild @name
    @name = new createjs.Text(@shownItems[@selected].data.name, "24px Arial", "black")
    @name.x = @pos.x + 10
    @name.y = @pos.y + 90
    @name.color = "black"
    @name.textBaseline = "alphabetic"
    @stage.addChild @name

    # Add the description. Use wrap to create lines
    @stage.removeChild(line) for line in @lines
    @lines = []

    lines = wrap(@canvas.getContext('2d'), @shownItems[@selected].data.description, @w - 20, "20px Arial")
    i = 0

    for line in lines
      text = new createjs.Text(line, "20px Arial", "black")
      text.x = @pos.x + 10
      text.y = @pos.y + i * 30 + 140
      text.color = "#333"
      text.textBaseline = "alphabetic"
      @stage.addChild text
      @lines.push text

      i++

  refresh: =>
    if @open
      @close()
      @showInventory()

  showInventory: =>
    # Position relative to the viewport
    @pos =
      x: @stage.x*-1 + 30
      y: @stage.y*-1 + 30

    @createBox()

    for i in [0..Inventory.items.length - 1] by 1
      item = Inventory.items[i]
      @shownItems.push new Item(@pos, @stage, item, i, @delegate)

    @shownItems[@selected]?.changeColor('tomato')

    @createText()
    @open = true
  close: =>
    @stage.removeChild @box
    @stage.removeChild @name
    item.close() for item in @shownItems
    @shownItems = []
    @stage.removeChild(line) for line in @lines
    @lines = []
    @open = false

  keyPress: (key) =>
    switch key
      when "esc"
        @close()
        @endInventory()
      when "left"
        if @selected > 0
          @shownItems[@selected].changeColor 'black'
          @selected--
          @shownItems[@selected].changeColor 'tomato'
          @createText()
      when "right"
        if @selected < @shownItems.length - 1
          @shownItems[@selected].changeColor 'black'
          @selected++
          @shownItems[@selected].changeColor 'tomato'
          @createText()

  class Item
    constructor: (pos, @stage, item, i, @delegate) ->

      # w and h better be factors of inventory.w/h
      @w = 50
      @h = 50

      Collections = require 'coffee/collections'
      @data = Collections.findModel item

      @pos =
        x: pos.x + i*@w + 7
        y: pos.y + 7

      spriteName = if (t = @data.type) then "#{t}Sprite" else "noitemSprite"
      sprite = _.clone(@delegate[spriteName] or @delegate.noitemSprite)
      @box = sprite
      @box.x = @pos.x
      @box.y = @pos.y
      @box.scaleX = @w/sprite.spriteSheet._frameHeight
      @box.scaleY = @h/sprite.spriteSheet._frameWidth

      @stage.addChild @box

      @mask = new createjs.Shape()
      @mask.graphics.beginStroke('black')
      @mask.graphics.setStrokeStyle(2)
      @mask.snapToPixel = true
      @mask.graphics.drawRect(@pos.x, @pos.y, @w, @h)

      @stage.addChild @mask

    changeColor: (color) ->
      @stage.removeChild @mask
      @mask.graphics.beginStroke(color)
      @mask.graphics.drawRect(@pos.x, @pos.y, @w, @h)
      @stage.addChild @mask
    close: ->
      @stage.removeChild @box
      @stage.removeChild @mask
