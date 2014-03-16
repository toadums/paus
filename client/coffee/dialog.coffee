Collections = require 'coffee/collections'
{ wrap } = require 'coffee/utils'
# Dialog class for dialogs. For right now just a yes/no box. We could make a 'done' box too
# WORK IN PROGRESS. We need to figure out a better way. use containers

class DialogManager
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endAction
    } = @delegate

    @currentDialog = null
    @dialog = null
    @lines = []

  # Draw the box that holds the dialog
  createBox: (pos) ->
    @box = new createjs.Shape()
    @box.graphics.beginStroke("#000")
    @box.graphics.beginFill("#51D9FF")
    @box.graphics.setStrokeStyle(2)
    @box.snapToPixel = true
    @box.graphics.drawRect(pos.x - 20, pos.y - 20, 300, 200)
    @stage.addChild @box

  # Render the text inside the dialog
  createText: (pos, dialog) ->
    lines = wrap(@canvas.getContext('2d'), dialog.text, 250, "20px Arial")
    i = 0

    for line in lines
      text = new createjs.Text(line, "20px Arial", "black")
      text.x = pos.x
      text.y = pos.y + i * 30
      text.snapToPixel = true
      text.textBaseline = "alphabetic"
      @stage.addChild text
      @lines.push text
      i++

  showDialog: (dialog) =>

    # Position relative to the viewport
    pos =
      x: @stage.x*-1 + 50
      y: @stage.y*-1 + 50


    @createBox pos
    @createText pos, dialog

    @dialog = new Controls dialog, pos, @


  close: =>
    @stage.removeChild text for text in @lines
    @lines = []
    @stage.removeChild @box
    @currentDialog = null
    @dialog = null


# Simple dialog with yes/no buttons
class Controls
  constructor: (@dialog, pos, @delegate) ->
    {
      close: @delegateClose
      @stage
      @showDialog
      @endAction
    } = @delegate


    @yes = new createjs.Text(dialog.action.text, "20px Arial", "black")
    @yes.x = pos.x
    @yes.y = pos.y + 100
    @yes.textBaseline = "alphabetic"

    @yes.addEventListener "click", @handleNext
    @stage.addChild @yes

  # Close the dialog when a yes/no button is hit
  handleNext: () =>
    if @dialog.action.type isnt 'goto'
      @close()
      @endAction()
    else
      next = @dialog.action.value
      newDialog = Collections.findModel(next)

      @close()
      return unless newDialog

      @showDialog newDialog

  close: =>
    @stage.removeChild @yes
    @delegateClose()



module.exports =
  DialogManager: DialogManager
