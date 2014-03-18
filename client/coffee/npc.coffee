Character = require 'coffee/character'
Collections = require 'coffee/collections'

module.exports = class NPC extends Character
  constructor: (sprite, giver) ->
    super sprite
    @giverSprite = giver
    @setGiver = false
    @defaultSprite = sprite.spriteSheet

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
          return dialog.state
      else if dialog.type is 'queststart'
        if not quest.inProgress
          return dialog.state

  tick: (event, level) =>
    switch @getQuestState()
      when 'hasquest'
        if @playerBody.currentAnimation isnt "stand"
          @playerBody.spriteSheet = _.clone(@giverSprite)
          @playerBody.gotoAndPlay "stand"
          @playerBody.framerate = 7
          @setGiver = true
        console.log "Show exclamation point"

      when 'return'
        console.log 'return to me precious child'

      else
        if @playerBody.currentAnimation is "stand"
          @playerBody.spriteSheet = _.clone(@defaultSprite)
          @playerBody.gotoAndPlay "down_idle"
