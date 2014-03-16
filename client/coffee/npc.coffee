Character = require 'coffee/character'
Collections = require 'coffee/collections'

module.exports = class NPC extends Character
  constructor: (sprite) ->
    super sprite

  init: (data) =>
    super data.pos
    @dialogs = data.dialogs

  getDialog: () =>
    for dialog in @dialogs
      quest = Collections.findModel dialog.quest

      if dialog.type is 'questpart'
        if quest.checkPartStatus(dialog.part)
          return dialog.dialog
      else if dialog.type is 'questdone'
        if quest.isComplete
          return dialog.dialog
      else if dialog.type is 'quest'
        if quest.inProgress
          return dialog.dialog
      else
        return dialog.dialog

  tick: (event, level) =>
    # They probably aren't going to do much. Could make some walk around or some shit