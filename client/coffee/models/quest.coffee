Inventory = require 'coffee/inventory'
Marker = require 'coffee/models/questpart'

module.exports = class Quest
  constructor: (data) ->
    @name = data.name
    @state = 0
    @id = data.id
    @markers = {}
    for marker in data.markers
      @markers[marker.pos] = new Marker(marker)
    @ordered = data.ordered or true
    @inProgress = false
    @isComplete
    @onComplete = data.onComplete

  completePart: (part) =>
    return unless @inProgress
    part = @getPart part
    passed = @checkPartStatus part

    return false unless passed

    part.done = true
    @state = part.pos + 1

    if (com = part.onComplete)?
      if com.type is 'item'
        Inventory.items.push com.id

    if @checkComplete()

      @complete()

      @inProgress = false
      @isComplete = true

    true

  checkComplete: =>
    @inProgress and not (_.find @markers, (m) -> not m.done)?

  start: =>
    @inProgress = true

  checkPartStatus: (part) =>
    return false if not @inProgress

    conditionPassed = true
    if part.condition?
      conditionPassed = @checkPartCondition part.condition

    if not conditionPassed
      return false
    else if part.pos isnt @state
      return false

    true

  isCurrentPart: (part) =>
    @getPart(part)?.pos is @state

  checkPartCondition: (cond) =>
    switch cond.type
      when 'inventory'
        return (_.without cond.items, Inventory.items...).length is 0

  getPart: (id) =>
    _.find @markers, (m) => m.id is id

  complete: () =>
    return unless @onComplete?
    switch @onComplete.type
      when 'item'
        Inventory.items.push @onComplete.id
      when 'cb'
        @[@onComplete.name]()

  finishMain: () =>
    Inventory.items = _.without Inventory.items, [351, 352, 353, 354]...
    Inventory.items.push 666
