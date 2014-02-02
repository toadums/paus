# Dialog class for dialogs. For right now just a yes/no box. We could make a 'done' box too
# WORK IN PROGRESS. We need to figure out a better way. use containers
class Dialog

  constructor: (@dialog, @delegate) ->
    {
      @stage
      @endAction
    } = @delegate

    @text = null

    # Position relative to the viewport
    @pos =
      x: @stage.x*-1 + 50
      y: @stage.y*-1 + 50

    # The backing box of the dialog
    @box = new createjs.Shape();
    @box.graphics.beginStroke("#000");
    @box.graphics.beginFill("#51D9FF")
    @box.graphics.setStrokeStyle(2);
    @box.snapToPixel = true;
    @box.graphics.drawRect(@pos.x - 20, @pos.y - 20, 300, 200);
    @stage.addChild @box

    @changeText @dialog.text

  # Set the text of the dialog
  changeText: (text) =>
    @text = new createjs.Text(text, "20px Arial", "black")
    @text.x = @pos.x
    @text.y = @pos.y
    @text.snapToPixel = true
    @text.textBaseline = "alphabetic"

    @stage.addChild @text

# Simple dialog with yes/no buttons
class YesNoDialog extends Dialog
  constructor: (dialog, delegate) ->
    super dialog, delegate

    @yes = new createjs.Text("Yes", "20px Arial", "black")
    @yes.x = @pos.x
    @yes.y = @pos.y + 100
    @yes.textBaseline = "alphabetic"

    @yes.addEventListener "click", @handleYes

    @stage.addChild @yes

  # Close the dialog when a yes/no button is hit
  handleYes: () =>
    @stage.removeChild @text
    @stage.removeChild @yes
    @stage.removeChild @box
    @endAction()
  handleNo: () =>
    @endAction()




module.exports =
  YesNoDialog: YesNoDialog
  Dialog:      Dialog