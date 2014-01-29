Character = require 'coffee/character'

module.exports = class npc extends Character
  constructor: (sprite) ->
    super sprite

  init: (pos) =>
    super pos

    @dialog =
      text: "Hello traveller"

  tick: (event, level) =>
    # They probably aren't going to do much. Could make some walk around or some shit