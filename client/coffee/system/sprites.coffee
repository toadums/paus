playerSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("player2")]
    frames:
      regX: 0
      height: 179
      count: 96
      regY: 0
      width: 134

    animations:
      up: [0, 2, "up"]
      right: [12, 14, "right"]
      down: [24, 26, "down"]
      left: [36, 38, "left"]

      left_attack_sword:
        frames: [39, 55, 62, 62, 62]
      right_attack_sword:
        frames: [5, 16, 62, 62, 62]
      up_attack_sword:
        frames: [8, 18, 62, 62, 62]
      down_attack_sword:
        frames: [30, 41, 62, 62, 62]

      left_attack:
        frames: [87, 88, 89]
      right_attack:
        frames: [63, 64, 65]
      up_attack:
        frames: [51, 52, 53]
      down_attack:
        frames: [75, 76, 77]

      left_idle: [37, 37]
      right_idle: [13, 13]
      up_idle: [1, 1]
      down_idle: [25, 25]
  )

  playerSprite = new createjs.Sprite(data, "right_idle")
  playerSprite.framerate = 10
  playerSprite

exclamationSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("exclamation")]
    frames:
      regX: 0
      height: 201
      count: 9
      regY: 0
      width: 67

    animations:
      bounce: [0, 8, "bounce"]
  )

  exclamation = new createjs.Sprite(data, "bounce")
  exclamation.framerate = 10
  exclamation

questionSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("question")]
    frames:
      regX: 0
      height: 201
      count: 9
      regY: 0
      width: 67

    animations:
      bounce: [0, 8, "bounce"]
  )

  question = new createjs.Sprite(data, "bounce")
  question.framerate = 10
  question

monsterSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSprite = new createjs.Sprite(data, "right_idle")
  monsterSprite.framerate = 10
  monsterSprite

monster2Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster2")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSprite2 = new createjs.Sprite(data, "right_idle")
  monsterSprite2.framerate = 10
  monsterSprite2

monster3Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster3")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSprite2 = new createjs.Sprite(data, "right_idle")
  monsterSprite2.framerate = 10
  monsterSprite2

monster4Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster4")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSprite2 = new createjs.Sprite(data, "right_idle")
  monsterSprite2.framerate = 10
  monsterSprite2

monster5Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster5")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSprite2 = new createjs.Sprite(data, "right_idle")
  monsterSprite2.framerate = 10
  monsterSprite2

monsterRedSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monsterred")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSpritered = new createjs.Sprite(data, "right_idle")
  monsterSpritered.framerate = 10
  monsterSpritered

monsterRed2Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster2red")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSpritered = new createjs.Sprite(data, "right_idle")
  monsterSpritered.framerate = 10
  monsterSpritered

monsterRed3Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster3red")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSpritered = new createjs.Sprite(data, "right_idle")
  monsterSpritered.framerate = 10
  monsterSpritered

monsterRed4Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster4red")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSpritered = new createjs.Sprite(data, "right_idle")
  monsterSpritered.framerate = 10
  monsterSpritered

monsterRed5Sprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("monster5red")]
    frames:
      regX: 0
      height: 130
      count: 12
      regY: 0
      width: 130

    animations:
      down: [0, 2, "down"]
      left: [3, 5, "left"]
      right: [6, 8, "right"]
      up: [9, 11, "up"]
      left_idle: [4,4]
      right_idle: [7,7]
      up_idle: [9, 9]
      down_idle: [0, 0]
  )

  monsterSpritered = new createjs.Sprite(data, "right_idle")
  monsterSpritered.framerate = 10
  monsterSpritered

bloodSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("bloodPool")]
    frames:
      regX: 0
      height: 130
      count: 1
      regY: 0
      width: 130

    animations:
      down: [0, 0, "down"]
      left: [0, 0, "left"]
      right: [0, 0, "right"]
      up: [0, 0, "up"]
      left_idle: [0, 0]
      right_idle: [0, 0]
      up_idle: [0, 0]
      down_idle: [0, 0]
  )

  data

arrowSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("arrow")]
    frames:
      regX: 0
      height: 50
      count: 1
      regY: 0
      width: 50

    animations:
      default: [0, 0]
  )

  arrowSprite = new createjs.Sprite(data, "default")
  arrowSprite.framerate = 10
  arrowSprite

signSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("sign")]
    frames:
      regX: 0
      height: 310
      count: 1
      regY: 0
      width: 330

    animations:
      default: [0, 0]
  )

  signSprite = new createjs.Sprite(data, "default")
  signSprite.framerate = 10
  signSprite

barrelSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("barrel")]
    frames:
      regX: 0
      height: 200
      count: 1
      regY: 0
      width: 200

    animations:
      default: [0, 0]
  )

  barrelSprite = new createjs.Sprite(data, "default")
  barrelSprite.framerate = 10
  barrelSprite

blankSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("blank")]
    frames:
      regX: 0
      height: 96*y
      count: 1
      regY: 0
      width: 96*x

    animations:
      default: [0, 0]
  )

  blankSprite = new createjs.Sprite(data, "default")
  blankSprite.framerate = 10
  blankSprite

trapSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("trap")]
    frames:
      regX: 0
      height: 96
      count: 1
      regY: 0
      width: 96

    animations:
      default: [0, 0]
  )

  trapSprite = new createjs.Sprite(data, "default")
  trapSprite.framerate = 10
  trapSprite

noitemSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("noitem")]
    frames:
      regX: 0
      height: 50
      count: 1
      regY: 0
      width: 50

    animations:
      default: [0, 0]
  )

  noitemSprite = new createjs.Sprite(data, "default")
  noitemSprite.framerate = 10
  noitemSprite

amplifierSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("amplifier")]
    frames:
      regX: 0
      height: 96
      count: 1
      regY: 0
      width: 96

    animations:
      default: [0, 0]
  )

  amplifierSprite = new createjs.Sprite(data, "default")
  amplifierSprite.framerate = 10
  amplifierSprite

carrotSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("carrot")]
    frames:
      regX: 0
      height: 50
      count: 1
      regY: 0
      width: 50

    animations:
      default: [0, 0]
  )

  carrotSprite = new createjs.Sprite(data, "default")
  carrotSprite.framerate = 10
  carrotSprite

remoteSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("remote")]
    frames:
      regX: 0
      height: 50
      count: 1
      regY: 0
      width: 50

    animations:
      default: [0, 0]
  )

  remoteSprite = new createjs.Sprite(data, "default")
  remoteSprite.framerate = 10
  remoteSprite

noteSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("note")]
    frames:
      regX: 0
      height: 96
      count: 1
      regY: 0
      width: 96

    animations:
      default: [0, 0]
  )

  noteSprite = new createjs.Sprite(data, "default")
  noteSprite.framerate = 10
  noteSprite

deactivatorSprite = (loader, x, y) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("deactivator")]
    frames:
      regX: 0
      height: 96
      count: 1
      regY: 0
      width: 96

    animations:
      default: [0, 0]
  )

  deactivatorSprite = new createjs.Sprite(data, "default")
  deactivatorSprite.framerate = 10
  deactivatorSprite


module.exports =
  playerSprite: playerSprite
  exclamationSprite: exclamationSprite
  questionSprite: questionSprite
  monsterSprite: monsterSprite
  monster2Sprite: monster2Sprite
  monster3Sprite: monster3Sprite
  monster4Sprite: monster4Sprite
  monster5Sprite: monster5Sprite
  monsterRedSprite: monsterRedSprite
  monsterRed2Sprite: monsterRed2Sprite
  monsterRed3Sprite: monsterRed3Sprite
  monsterRed4Sprite: monsterRed4Sprite
  monsterRed5Sprite: monsterRed5Sprite
  bloodSprite: bloodSprite
  arrowSprite: arrowSprite
  signSprite: signSprite
  barrelSprite: barrelSprite
  blankSprite: blankSprite
  trapSprite: trapSprite
  noitemSprite: noitemSprite
  amplifierSprite: amplifierSprite
  carrotSprite: carrotSprite
  remoteSprite: remoteSprite
  noteSprite: noteSprite
  deactivatorSprite: deactivatorSprite
