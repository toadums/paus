Collections = require 'coffee/collections'
{ wrap } = require 'coffee/utils'

class DialogManager
  constructor: (@delegate) ->
    {
      @canvas
      @stage
      @endAction
      @setQuest
      @gameover
    } = @delegate

    @currentDialog = null
    @dialog = null
    @lines = []
    @margin = 40
    @padding = 40
    @w = @stage.canvas.width - @margin*2
    @h = 160

  # Draw the box that holds the dialog
  createBox: (pos) ->
    @box = new createjs.Shape()
    @box.graphics.beginStroke("rgb(230,230,230)")
    @box.graphics.beginFill("black")
    @box.graphics.setStrokeStyle(2)
    @box.snapToPixel = true
    @box.graphics.drawRect(pos.x, pos.y, @w, @h)
    @stage.addChild @box

  # Render the text inside the dialog
  createText: (pos, dialog) =>
    lines = wrap(@canvas.getContext('2d'), dialog.text, @w - @padding*2, "26px VT323")
    i = 0

    for line in lines
      text = new createjs.Text(line, "26px VT323", "rgb(0,255,0)")
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
        @endAction()

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
      @gameover
    } = @delegate

    @active = 0

    @buttons = []
    i = 0

    # Add the buttons
    for action in dialog.actions
      button = new createjs.Text(action.text, "26px VT323", if i is 0 then "white" else "rgb(0,255,0)")
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
      @buttons[@active].color = "rgb(0,255,0)"
      @active++
    else if direction is "left" and @active > 0
      @buttons[@active].color = "rgb(0,255,0)"
      @active--

    @buttons[@active].color = "white"

  # Enter was pressed. Handle the action for the active button
  enterPress: =>
    @buttons[@active].dispatchEvent('click')

  # Close the dialog when a yes/no button is hit
  handleNext: (action, data, ev) =>
    if action.type is 'goto'
      next = action.value

      @close()
      if not next
        @endAction()
        return

      @showDialog next

    else if action.type is 'gameover'
      @endAction()
      @gameover(action.value or "You lost..")
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
        partComplete = quest.completePart action.value.part
        next = if partComplete then action.value.success else action.value.fail
        @close()

        if not next
          @endAction()
        else
          @showDialog next

      else
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
