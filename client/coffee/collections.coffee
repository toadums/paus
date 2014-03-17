Quest = require 'coffee/models/quest'
_dialogs = require 'coffee/data/dialogs'
_quests = require 'coffee/data/quests'

console.log _quests

quests = (new Quest(quest) for quest in _quests)

dialogs = (dialog for dialog in _dialogs)

module.exports =
  findModel: (id) ->
    _.find dialogs.concat(quests), (d) -> d.id is id
