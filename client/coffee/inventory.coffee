Collections = require 'coffee/collections'
{ wrap } = require 'coffee/utils'
# Dialog class for dialogs. For right now just a yes/no box. We could make a 'done' box too
# WORK IN PROGRESS. We need to figure out a better way. use containers

class Inventory
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endInventory
    } = @delegate

    @w = @stage.canvas.width/3
    @h = 400

  # Draw the box that holds the dialog
  createBox: (pos) ->
    @box = new createjs.Shape()
    @box.graphics.beginStroke("#000")
    @box.graphics.beginFill("#8A8A8A")
    @box.graphics.setStrokeStyle(10)
    @box.snapToPixel = true
    @box.graphics.drawRect(pos.x, pos.y, @w, @h)
    @stage.addChild @box

  showInventory: () =>

    # Position relative to the viewport
    pos =
      x: @stage.x*-1 + 30
      y: @stage.y*-1 + @stage.canvas.height - @h - 30

    @createBox pos

  close: =>
    @stage.removeChild @box

  keyPress: (key) =>
    switch key
      when "esc"
        @close()
        @endInventory()

module.exports =
  Inventory: Inventory
