module.exports =[
  {
    dialogs: [
      { type: 'questpart', quest: 900, part: 802, dialog: 128, state: 'return' }
      { type: 'questpart', quest: 900, part: 801, dialog: 125 }
      { type: 'queststart', quest: 900, dialog: 123, state: 'hasquest' }
      { type: 'questdone', quest: 900, dialog: 129 }
    ]

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

    pos:
      x: 900
      y: 1200
  }


]
