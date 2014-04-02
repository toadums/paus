module.exports = class Instructions

  constructor: (@delegate) ->
    {
      @stage
      @startGame
      @keyInput
      @showHome
    } = @delegate

    @components = []
    @visible = false

  show: =>
    @visible = true
    @addInstructions()

  addInstructions: =>
    x = 200
    move = new createjs.Text("wasd/arrows - move", "20px Arial", "white")
    move.x = x
    move.y = 100
    move.snapToPixel = true
    move.textBaseline = "alphabetic"

    attk = new createjs.Text("space/left click - attack", "20px Arial", "white")
    attk.x = x
    attk.y = 150
    attk.snapToPixel = true
    attk.textBaseline = "alphabetic"

    inv = new createjs.Text("I - inventory", "20px Arial", "white")
    inv.x = x
    inv.y = 200
    inv.snapToPixel = true
    inv.textBaseline = "alphabetic"

    map = new createjs.Text("M (hold) - show map", "20px Arial", "white")
    map.x = x
    map.y = 250
    map.snapToPixel = true
    map.textBaseline = "alphabetic"

    act = new createjs.Text("E - Interact with NPC", "20px Arial", "white")
    act.x = x
    act.y = 300
    act.snapToPixel = true
    act.textBaseline = "alphabetic"

    clk = new createjs.Text("Left Click - Pick things up, attack, talk", "20px Arial", "white")
    clk.x = x
    clk.y = 350
    clk.snapToPixel = true
    clk.textBaseline = "alphabetic"


    esc = new createjs.Text("(esc to go back)", "14px Arial", "white")
    esc.x = x
    esc.y = 420
    esc.snapToPixel = true
    esc.textBaseline = "alphabetic"

    @stage.addChild move
    @stage.addChild attk
    @stage.addChild inv
    @stage.addChild map
    @stage.addChild act
    @stage.addChild clk
    @stage.addChild esc

    @components.push move
    @components.push attk
    @components.push inv
    @components.push map
    @components.push act
    @components.push clk
    @components.push exc

    @stage.update()

  close: =>
    @visible = false
    @stage.removeChild(comp) for comp in @components

  tick: (event) =>

    if @keyInput.escHeld
      @showHome()
      @close()

    @stage.update()
