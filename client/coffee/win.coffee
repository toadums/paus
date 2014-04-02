module.exports = class Win

  constructor: (@delegate) ->
    {
      @stage
      @keyInput
      @showHome
    } = @delegate

    @visible = false
    @components = []


  addText: =>
    @stage.x = 0
    @stage.y = 0

    text = new createjs.Text "You deactivated all the bunnies! You Winner", "20px Arial", "yellow"
    text.x = 200
    text.y = 400
    text.snapToPixel = true
    text.textBaseline = "alphabetic"

    esc = new createjs.Text("(esc to go back)", "14px Arial", "white")
    esc.x = 200
    esc.y = 300
    esc.snapToPixel = true
    esc.textBaseline = "alphabetic"

    @stage.addChild text
    @stage.addChild esc
    @components.push text
    @components.push esc
    @stage.update()



  show: =>
    @visible = true
    @addText()

  close: =>
    @visible = false
    @stage.removeChild(comp) for comp in @components
    @components = []

  tick: (event) =>
    if @keyInput.escHeld
      @close()
      @showHome()
