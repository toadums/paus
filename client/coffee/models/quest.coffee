Marker = require 'coffee/models/questpart'

module.exports = class Quest
  constructor: (data) ->
    @name = data.name
    @state = 0
    @id = data.id
    @markers = []
    for marker in data.markers
      @markers.push new Marker(marker)
    @ordered = data.ordered or true
    @inProgress = false
    @isComplete

  completePart: (part) =>
    return unless @inProgress
    part = @getPart part
    return if @checkPartStatus part

    part.done = true
    @state = part.pos + 1

    if @checkComplete()
      console.log "You finished the quest!"
      @inProgress = false
      @isComplete = true

  checkComplete: =>
    @inProgress and not (_.find @markers, (m) -> not m.done)?

  start: =>
    @inProgress = true

  checkPartStatus: (part) =>
    return false unless @inProgress
    not @ordered or @getPart(part)?.pos is @state

  getPart: (id) =>
    _.find @markers, (m) => m.id is id