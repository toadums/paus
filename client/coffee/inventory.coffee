Collections = require 'coffee/collections'
{ wrap } = require 'coffee/utils'

# Dialog class for dialogs. For right now just a yes/no box. We could make a 'done' box too
# WORK IN PROGRESS. We need to figure out a better way. use containers

module.exports = class Inventory
  @items = []
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endInventory
    } = @delegate

    @w = 420
    @h = 220
    @items = []

  # Draw the box that holds the dialog
  createBox: (pos) ->
    @box = new createjs.Shape()
    @box.graphics.beginStroke("#000")
    @box.graphics.beginFill("#8A8A8A")
    @box.graphics.setStrokeStyle(10)
    @box.snapToPixel = true
    @box.graphics.drawRect(pos.x, pos.y, @w, @h)
    @stage.addChild @box

  showInventory: =>
    # Position relative to the viewport
    pos =
      x: @stage.x*-1 + 30
      y: @stage.y*-1 + 30

    @createBox pos

    for i in [0..Inventory.items.length - 1] by 1
      item = Inventory.items[i]
      @items.push new Item(pos, @stage, item, i)

  close: =>
    @stage.removeChild @box
    item.close() for item in @items
    @items = []

  keyPress: (key) =>
    switch key
      when "esc"
        @close()
        @endInventory()

  class Item
    constructor: (pos, @stage, sprite, i) -> # NOTE: sprite is currently just a color

      # w and h better be factors of inventory.w/h
      @w = 50
      @h = 50
      console.log pos
      @box = new createjs.Shape()
      @box.graphics.beginStroke('red')
      @box.graphics.beginFill("#8A8A8A")
      @box.graphics.setStrokeStyle(10)
      @box.snapToPixel = true
      @box.graphics.drawRect(pos.x + i*@w + 10, pos.y + 10, @w, @h)
      @stage.addChild @box

    close: ->
      @stage.removeChild @box
