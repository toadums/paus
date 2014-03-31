Collections = require 'coffee/collections'
{ wrap } = require 'coffee/utils'

class DialogManager
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endAction
      @setQuest
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
    @box.graphics.beginFill("papayawhip")
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

  showDialog: (id) =>
    dialog = Collections.findModel id

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

  # Handle key events in the dialogs
  keyPress: (key) =>
    switch key
      when "left", "right"
        @dialog.changeSelection key
      when "enter"
        @dialog.enterPress()
      when "esc"
        @dialog.close()

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
      @setQuest
    } = @delegate

    @active = 0

    @buttons = []
    i = 0

    # Add the buttons
    for action in dialog.actions
      button = new createjs.Text(action.text, "20px Arial", if i is 0 then "red" else "black")
      button.x = pos.x + @padding + i * 300
      button.y = pos.y + @h - @padding
      button.textBaseline = "alphabetic"

      button.addEventListener "click", _.partial @handleNext, action, _
      @buttons.push button
      @stage.addChild button
      i++

  # Change which button is active
  changeSelection: (direction) ->
    if direction is "right" and @active < @buttons.length - 1
      @buttons[@active].color = "black"
      @active++
    else if direction is "left" and @active > 0
      @buttons[@active].color = "black"
      @active--

    @buttons[@active].color = "red"

  # Enter was pressed. Handle the action for the active button
  enterPress: =>
    @buttons[@active].dispatchEvent('click')

  # Close the dialog when a yes/no button is hit
  handleNext: (action, data, ev) =>
    if action.type is 'goto'
      next = action.value

      @close()
      return unless next

      @showDialog next
    # Start a quest!!
    else if action.type is 'queststart'

      if (quest = Collections.findModel action.value.quest)
        quest.start()
        @setQuest quest
      @close()
      @endAction()

    # Complete a quest part
    else if action.type is 'questpart'
      if (quest = Collections.findModel action.value.quest)?
        quest.completePart action.value.part

      @close()
      @endAction()
    else
      @close()
      @endAction()

    ev.stopPropagation()

  close: =>
    @stage.removeChild button for button in @buttons
    @buttons = []
    @delegateClose()



module.exports =
  DialogManager: DialogManager
