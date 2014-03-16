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
    @margin = 40
    @padding = 20
    @w = @stage.canvas.width - @margin*2
    @h = 160

  # Draw the box that holds the dialog
  createBox: (pos) ->
    @box = new createjs.Shape()
    @box.graphics.beginStroke("#000")
    @box.graphics.beginFill("#51D9FF")
    @box.graphics.setStrokeStyle(2)
    @box.snapToPixel = true
    @box.graphics.drawRect(pos.x, pos.y, @w, @h)
    @stage.addChild @box

  # Render the text inside the dialog
  createText: (pos, dialog) =>
    lines = wrap(@canvas.getContext('2d'), dialog.text, @w - @padding*2, "20px Arial")
    i = 0

    for line in lines
      text = new createjs.Text(line, "20px Arial", "black")
      text.x = pos.x + @padding
      text.y = pos.y + i * 30 + @padding
      text.snapToPixel = true
      text.textBaseline = "alphabetic"
      @stage.addChild text
      @lines.push text
      i++

  showDialog: (dialog) =>

    # Position relative to the viewport
    pos =
      x: @stage.x*-1 + @margin
      y: @stage.y*-1 + @stage.canvas.height - @h - @margin

    @createBox pos
    @createText pos, dialog

    @dialog = new Controls dialog, pos, @


  close: =>
    @stage.removeChild text for text in @lines
    @lines = []
    @stage.removeChild @box
    @currentDialog = null
    @dialog = null

  keyPress: (key) =>
    switch key
      when "left", "right"
        @dialog.changeSelection key
      when "enter"
        @dialog.enterPress()

# Simple dialog with yes/no buttons
class Controls
  constructor: (@dialog, pos, @delegate) ->
    {
      close: @delegateClose
      @stage
      @showDialog
      @endAction
      @padding
      @h
    } = @delegate

    @active = 0

    @buttons = []
    i = 0
    for action in dialog.actions
      button = new createjs.Text(action.text, "20px Arial", if i is 0 then "red" else "black")
      button.x = pos.x + @padding + i * 300
      button.y = pos.y + @h - @padding
      button.textBaseline = "alphabetic"

      button.addEventListener "click", _.partial(@handleNext, action)
      @buttons.push button
      @stage.addChild button
      i++

  changeSelection: (direction) ->
    if direction is "right" and @active < @buttons.length - 1
      @buttons[@active].color = "black"
      @active++
    else if direction is "left" and @active > 0
      @buttons[@active].color = "black"
      @active--

    @buttons[@active].color = "red"

  enterPress: =>
    @buttons[@active].dispatchEvent('click')

  # Close the dialog when a yes/no button is hit
  handleNext: (action) =>
    if action.type is 'goto'
      next = action.value
      newDialog = Collections.findModel(next)

      @close()
      return unless newDialog

      @showDialog newDialog
    else
      @close()
      @endAction()

  close: =>
    @stage.removeChild button for button in @buttons
    @buttons = []
    @delegateClose()



module.exports =
  DialogManager: DialogManager
