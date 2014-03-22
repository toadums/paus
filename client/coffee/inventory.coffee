{ wrap } = require 'coffee/utils'
# Dialog class for dialogs. For right now just a yes/no box. We could make a 'done' box too
# WORK IN PROGRESS. We need to figure out a better way. use containers

module.exports = class Inventory
  @items = [301, 302]
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endInventory
    } = @delegate

    @w = 428
    @h = 128
    @shownItems = []
    @lines = []
    @selected = 0

  # Draw the box that holds the dialog
  createBox: =>
    @box = new createjs.Shape()
    @box.graphics.beginStroke("#000")
    @box.graphics.beginFill("#8A8A8A")
    @box.graphics.setStrokeStyle(2)
    @box.snapToPixel = true
    @box.graphics.drawRect(@pos.x, @pos.y, @w, @h)
    @stage.addChild @box


  createText: =>

    @stage.removeChild(line) for line in @lines
    @lines = []

    lines = wrap(@canvas.getContext('2d'), @shownItems[@selected].data.description, @w - 20, "20px Arial")
    i = 0

    for line in lines
      text = new createjs.Text(line, "20px Arial", "black")
      text.x = @pos.x + 10
      text.y = @pos.y + i * 30 + 80
      text.textBaseline = "alphabetic"
      @stage.addChild text
      @lines.push text

      i++

  showInventory: =>
    # Position relative to the viewport
    @pos =
      x: @stage.x*-1 + 30
      y: @stage.y*-1 + 30

    @createBox()

    for i in [0..Inventory.items.length - 1] by 1
      item = Inventory.items[i]
      @shownItems.push new Item(@pos, @stage, item, i)

    @shownItems[@selected].changeColor('red')

    @createText()

  close: =>
    @stage.removeChild @box
    item.close() for item in @shownItems
    @shownItems = []
    @stage.removeChild(line) for line in @lines
    @lines = []

  keyPress: (key) =>
    switch key
      when "esc"
        @close()
        @endInventory()
      when "left"
        if @selected > 0
          @shownItems[@selected].changeColor 'black'
          @selected--
          @shownItems[@selected].changeColor 'red'
          @createText()
      when "right"
        if @selected < @shownItems.length - 1
          @shownItems[@selected].changeColor 'black'
          @selected++
          @shownItems[@selected].changeColor 'red'
          @createText()

  class Item
    constructor: (pos, @stage, item, i) ->

      # w and h better be factors of inventory.w/h
      @w = 50
      @h = 50

      Collections = require 'coffee/collections'
      @data = Collections.findModel item
      console.log item, @data

      @pos =
        x: pos.x + i*@w + 7
        y: pos.y + 7

      @box = new createjs.Shape()
      @box.graphics.beginStroke('black')
      @box.graphics.beginFill("yellow")
      @box.graphics.setStrokeStyle(4)
      @box.snapToPixel = true
      @box.graphics.drawRect(@pos.x, @pos.y, @w, @h)
      @stage.addChild @box

    changeColor: (color) ->
      @stage.removeChild @box
      @box.graphics.beginStroke(color)
      @box.graphics.drawRect(@pos.x, @pos.y, @w, @h)
      @stage.addChild @box
    close: ->
      @stage.removeChild @box
