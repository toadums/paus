module.exports = class KeyInput
  constructor: () ->
    # KeyDown/Up defines
    @KEYCODE_UP = 38
    @KEYCODE_LEFT = 37
    @KEYCODE_RIGHT = 39
    @KEYCODE_DOWN = 40
    @KEYCODE_W = 87
    @KEYCODE_A = 65
    @KEYCODE_S = 83
    @KEYCODE_D = 68
    @ACTION = 69
    @ENTER = 13

    @lfHeld = undefined
    @rtHeld = undefined
    @fwdHeld = undefined
    @dnHeld = undefined
    # E key. Talk to people, interact etc
    @actionheld = undefined

    window.setTimeout(
      () =>
        document.onkeydown = @handleKeyDown
        document.onkeyup = @handleKeyUp
        document.onkeypress = @handleKeyPress
      1000
    )
  #allow for WASD and arrow control scheme
  handleKeyDown: (e) =>
    #cross browser issues exist
    e = window.event unless e
    switch e.keyCode
      when @KEYCODE_A, @KEYCODE_LEFT
        @lfHeld = true
        false
      when @KEYCODE_D, @KEYCODE_RIGHT
        @rtHeld = true
        false
      when @KEYCODE_W, @KEYCODE_UP
        @fwdHeld = true
        false
      when @KEYCODE_S, @KEYCODE_DOWN
        @dnHeld = true
        false
      when @ACTION
        @actionHeld = true
      when @ENTER
        @enterHeld = true

  handleKeyUp: (e) =>
    e = window.event  unless e
    switch e.keyCode
      when @KEYCODE_A, @KEYCODE_LEFT
        @lfHeld = false
      when @KEYCODE_D, @KEYCODE_RIGHT
        @rtHeld = false
      when @KEYCODE_W, @KEYCODE_UP
        @fwdHeld = false
      when @KEYCODE_S, @KEYCODE_DOWN
        @dnHeld = false
      when @ACTION
        @actionHeld = false
      when @ENTER
        @enterHeld = false

  reset: () =>
    @lfHeld = @rtHeld = @fwdHeld = @dnHeld = @enterHeld = @actionHeld = false
