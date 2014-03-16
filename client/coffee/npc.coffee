Character = require 'coffee/character'

module.exports = class NPC extends Character
  constructor: (sprite) ->
    super sprite

  init: (pos) =>
    super pos

    @dialog = 123

  tick: (event, level) =>
    # They probably aren't going to do much. Could make some walk around or some shit
