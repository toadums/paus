module.exports = [
  # {
  #   dialogs: [
  #     { type: 'questpart', quest: 900, part: 802, dialog: 128, state: 'return' }
  #     { type: 'questpart', quest: 900, part: 801, dialog: 125 }
  #     { type: 'queststart', quest: 900, dialog: 123, state: 'hasquest' }
  #     { type: 'questdone', quest: 900, dialog: 129 }
  #   ]
  #   id: 2
  #   pos:
  #     x: 100
  #     y: 1500
  # }
  #
  # {
  #   dialogs:
  #     [
  #       { type: 'questpart', quest: 900, part: 801, dialog: 127, state: 'return' }
  #       { type: 'else', dialog: 130 }
  #     ]
  #   id: 3
  #   pos:
  #     x: 1800
  #     y: 100
  # }

  ## Message left by old man. Prompt us to start quest
  {
    dialogs:
      [
        {type: 'queststart', quest: 901, dialog: 150, state: 'hasquest'}
        {type: 'else', quest: 901, dialog: 151}
      ]
    id: 4
    pos:
      x: 8570
      y: 8600
    sprite: "signSprite"
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
      y: 1200
  }

  ## The old man!
  {
    dialogs:
      [
        {type: 'queststart', quest: 911, dialog: 161, state: 'hasquest'}
      ]
    id: 6
    pos:
      x: 20
      y: 120
  }

  ## Note by 451
  {
    dialogs:
      [
        {type: 'questpart', quest: 911, part: 861, dialog: 172, state: 'return'}
      ]
    id: 8
    pos:
      x: 300
      y: 900
  }

  ## Sign to pick carrots
  {
    dialogs:
      [
        {type: 'questpart', quest: 911, part: 862, dialog: 173, state: 'return'}
      ]
    id: 9
    pos:
      x: 1000
      y: 400
  }


  {
    dialogs:
      [
        {type: 'easteregg', dialog: 171}
      ]
    id: 7
    pos:
      x: 500
      y: 900
  }

]
