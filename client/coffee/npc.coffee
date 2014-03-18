Character = require 'coffee/character'
Collections = require 'coffee/collections'

module.exports = class NPC extends Character
  constructor: (sprite, @exclamation, @question, @stage) ->
    super sprite
    @hasQuestion = false
    @hasExlaimation = false



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
        if not quest.inProgress and not quest.isComplete
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
        if not quest.inProgress and not quest.isComplete
          return dialog.state

  tick: (event, level) =>
    switch @getQuestState()
      when 'hasquest'
        if not @hasExclamation
          @stage.addChild @exclamation
          @exclamation.x = @x + @width/2 - 33.5
          @exclamation.y = @y - @height/2 - 80
          @hasExclamation = true
      when 'return'
        if not @hasQuestion
          @stage.addChild @question
          @question.x = @x + @width/2 - 33.5
          @question.y = @y - @height/2 - 80
          @hasQuestion = true
      else
        if @hasQuestion
          @stage.removeChild @question
          @hasQuestion = false

        if @hasExclamation
          @stage.removeChild @exclamation
          @hasExclamation = false
