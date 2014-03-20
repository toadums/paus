module.exports =[
  {
    dialogs: [
      { type: 'questpart', quest: 900, part: 802, dialog: 128, state: 'return' }
      { type: 'questpart', quest: 900, part: 801, dialog: 125 }
      { type: 'queststart', quest: 900, dialog: 123, state: 'hasquest' }
      { type: 'questdone', quest: 900, dialog: 129 }
    ]
    id: 2
    pos:
      x: 300
      y: 500
  }

  {
    dialogs:
      [
        { type: 'questpart', quest: 900, part: 801, dialog: 127, state: 'return' }
        { type: 'else', dialog: 130 }
      ]
    id: 3
    pos:
      x: 900
      y: 1200
  }

  ## Message left by old man. Prompt us to start quest
  {
    dialogs:
      [
        {type: 'queststart', quest: 901, dialog: 150, state: 'hasquest'}
        {type: 'else', quest: 901, dialog: 151}
      ]
    id: 4
    pos:
      x: 200
      y: 200
  }

  ## Look under a tree for the bunny disabler
  {
    dialogs:
      [
        {type: 'questpart', quest: 901, part: 850, dialog: 152, state: 'return'}
      ]
    id: 5
    pos:
      x: 900
      y: 900
  }


]
