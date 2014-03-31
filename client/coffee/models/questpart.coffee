module.exports = class Marker
  constructor: (data) ->
    @pos = data.pos
    @id = data.id
    @done = false
    @npc = data.npc
    @onComplete = data.onComplete
    @condition = data.cond
