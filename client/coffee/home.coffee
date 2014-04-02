module.exports = class Home

  constructor: (@delegate) ->
    {
      @stage
      @startGame
      @keyInput
      @toggleSound
      @showInstructions
    } = @delegate

    @components = []
    @controls = []
    @visible = false
    @selectedOption = 0

  show: =>
    @selectedOption = 0
    @visible = true
    @addStart()
    @addInstructions()
    @addSound()

  addStart: =>
    text = new createjs.Text("Play!", "20px Arial", "white")
    text.x = 200
    text.y = 300
    text.snapToPixel = true
    text.textBaseline = "alphabetic"

    text.onSelect = () =>
      @startGame()
      @close()

    @stage.addChild text
    @components.push text
    @controls.push text

    @stage.update()

  addInstructions: =>
    text = new createjs.Text("Instructions", "20px Arial", "white")
    text.x = 200
    text.y = 350
    text.snapToPixel = true
    text.textBaseline = "alphabetic"

    text.onSelect = () =>
      @showInstructions()
      @close()

    @stage.addChild text
    @components.push text
    @controls.push text

    @stage.update()

  addSound: =>
    text = new createjs.Text("Toggle Sound", "20px Arial", "white")
    text.x = 200
    text.y = 400
    text.snapToPixel = true
    text.textBaseline = "alphabetic"

    text.onSelect = () =>
      @toggleSound()

    @stage.addChild text
    @components.push text
    @controls.push text

    @stage.update()

  close: =>
    @visible = false
    @stage.removeChild(comp) for comp in @components
    @components = []
    @controls = []

  tick: (event) =>
    return unless @visible
    if @keyInput.enterHeld
      @controls[@selectedOption]?.onSelect()
      @keyInput.enterHeld = false
    else if @keyInput.dnHeld
      if @selectedOption < @controls.length - 1
        @controls[@selectedOption].color = "white"
        @selectedOption++
      @keyInput.dnHeld = false

    else if @keyInput.fwdHeld
      if @selectedOption > 0
        @controls[@selectedOption].color = "white"
        @selectedOption--
      @keyInput.fwdHeld = false

    @controls[@selectedOption]?.color = "rgb(0,255,0)"

    @stage.update()
