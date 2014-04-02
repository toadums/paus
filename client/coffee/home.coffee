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
    @img = document.createElement('img')
    @img.src = '/images/rw.png';

  show: =>
    @selectedOption = 0
    @visible = true
    @addHeader()
    @addStart()
    @addInstructions()
    @addSound()

  addHeader: =>


    scale = 800 / @img.width

    header = new createjs.Bitmap(@img)
    header.scaleX = scale
    header.scaleY = 400 / @img.height
    header.x = @stage.canvas.width/2 - 400
    header.y = 0
    @stage.addChild header
    @components.push header

  addStart: =>
    t = "Play!"
    ctx = @stage.canvas.getContext('2d')
    ctx.font = "36px Arial"

    x = @stage.canvas.width/2 - ctx.measureText(t).width/2

    text = new createjs.Text(t, "36px Arial", "white")
    text.x = x
    text.y = 400
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
    t = "Instructions"
    ctx = @stage.canvas.getContext('2d')
    ctx.font = "36px Arial"

    x = @stage.canvas.width/2 - ctx.measureText(t).width/2

    text = new createjs.Text(t, "36px Arial", "white")
    text.x = x
    text.y = 450
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
    t = "Toggle Sound"
    ctx = @stage.canvas.getContext('2d')
    ctx.font = "36px Arial"

    x = @stage.canvas.width/2 - ctx.measureText(t).width/2

    text = new createjs.Text(t, "36px Arial", "white")
    text.x = x
    text.y = 500
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

    @controls[@selectedOption]?.color = "rgb(175,0,0)"

    @stage.update()
