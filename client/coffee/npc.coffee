Character = require 'coffee/character'
Collections = require 'coffee/collections'

module.exports = class NPC extends Character
  constructor: (sprite, giver) ->
    super sprite
    @giverSprite = giver
    @setGiver = false

  init: (data) =>
    super data.pos
    @dialogs = data.dialogs

  # Figure out which dialog this person whould show.
  getDialog: () =>
    # Loop over all of their dialogs. For each one, check if it should be the one they display
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
      else if dialog.type is 'queststart'
        if not quest.inProgress
          return dialog.dialog
      else
        return dialog.dialog

  getQuestState: () =>
    for dialog in @dialogs
      quest = Collections.findModel dialog.quest

      if dialog.type is 'questpart'
        if quest.checkPartStatus(dialog.part)
          return 'questpart'
      else if dialog.type is 'queststart'
        if not quest.inProgress
          return 'queststart'

  tick: (event, level) =>
    switch @getQuestState()
      when 'queststart'
        if @playerBody.currentAnimation isnt "stand"
          @playerBody.spriteSheet = _.clone(@giverSprite)
          @playerBody.gotoAndPlay "stand"
          @playerBody.framerate = 7
          @setGiver = true
        console.log "Show exclamation point"
      when 'questpart'
        console.log 'show question mark'
