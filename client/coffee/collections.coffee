Quest = require 'coffee/models/quest'
_dialogs = require 'coffee/data/dialogs'
_quests = require 'coffee/data/quests'
_items = require 'coffee/data/items'

quests = (new Quest(quest) for quest in _quests)

dialogs = (dialog for dialog in _dialogs)

module.exports =

  reset: ->
    quests = (new Quest(quest) for quest in _quests)

    dialogs = (dialog for dialog in _dialogs)

  findModel: (id) ->

    _.find dialogs.concat(quests).concat(_items), (d) -> d.id is id
