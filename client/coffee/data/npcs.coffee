module.exports =[
  {
    dialogs: [
      { type: 'questpart', quest: 900, part: 802, dialog: 128 }
      { type: 'questpart', quest: 900, part: 801, dialog: 125 }
      { type: 'questdone', quest: 900, dialog: 129 }
      { type: 'queststart', quest: 900, dialog: 123 }
    ]

    pos:
      x: 300
      y: 500
  }

  {
    dialogs:
      [
        { type: 'questpart', quest: 900, part: 801, dialog: 127 }
        { type: 'else', dialog: 130 }
      ]

    pos:
      x: 900
      y: 1200
  }


]
