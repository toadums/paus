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


  ## SUB sign
  {
    dialogs:
      [
        {type: 'else', dialog: 190}
      ]
    id: 90
    pos:
      x: 7896
      y: 8860
    sprite: "signSprite"
  }

  ## Clearihue sign
  {
    dialogs:
      [
        {type: 'else', dialog: 191}
      ]
    id: 91
    pos:
      x: 8016
      y: 6650
    sprite: "signSprite"
  }

  ## Cornett sign
  {
    dialogs:
      [
        {type: 'else', dialog: 192}
      ]
    id: 92
    pos:
      x: 8796
      y: 4300
    sprite: "signSprite"
  }

  ## SSM sign
  {
    dialogs:
      [
        {type: 'else', dialog: 193}
      ]
    id: 93
    pos:
      x: 8646
      y: 1596
    sprite: "signSprite"
  }

  ## Elliot sign
  {
    dialogs:
      [
        {type: 'else', dialog: 194}
      ]
    id: 94
    pos:
      x: 1756
      y: 5600
    sprite: "signSprite"
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
      x: 8666
      y: 8600
    sprite: "signSprite"
  }

  ## Barrel with the sword
  {
    dialogs:
      [
        {type: 'questpart', quest: 901, part: 850, dialog: 152, state: 'return'}
      ]
    id: 5
    pos:
      x: 5836
      y: 220
    sprite: "barrelSprite"
  }



  ## The hole
  {
    dialogs:
      [
        {type: 'queststart', quest: 911, dialog: 161, state: 'hasquest'}
      ]
    id: 6
    pos:
      x: 4146
      y: 3820
    sprite: "barrelSprite"
    size:
      x: 2
      y: 2

  }

  ## Note by 451
  {
    dialogs:
      [
        {type: 'questpart', quest: 911, part: 861, dialog: 172, state: 'return'}
      ]
    id: 8
    pos:
      x: 3216
      y: 8940
  }

  ## Sign to pick carrots
  {
    dialogs:
      [
        {type: 'questpart', quest: 911, part: 862, dialog: 174, state: 'return'}
      ]
    id: 9
    pos:
      x: 7100
      y: 2950
  }


  {
    dialogs:
      [
        {type: 'easteregg', dialog: 171}
      ]
    id: 7
    pos:
      x: 4946
      y: 8600
    sprite: "signSprite"
  }

]
