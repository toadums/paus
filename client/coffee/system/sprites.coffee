playerSprite = (loader) ->
  data = new createjs.SpriteSheet(
    images: [loader.getResult("player")]
    frames:
      regX: 0
      height: 206
      count: 12
      regY: 0
      width: 130

    animations:
      up: [0, 2, "up"]
      right: [3, 5, "right"]
      down: [6, 8, "down"]
      left: [9, 11, "left"]
      left_idle: [9, 9]
      right_idle: [3, 3]
      up_idle: [0, 0]
      down_idle: [7, 7]
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
