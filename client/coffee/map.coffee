# There are 3 parts to the map. The image, the border and the dot

module.exports = class Map
  constructor: (@stage, @img) ->

  update: (stage, playerX, playerY, moving) =>

    # Make transparent if moving
    alpha = if moving then 0.5 else 1

    # The image size is based on the canvas height (like always?)
    size = Math.min stage.canvas.width - 150, stage.canvas.height - 150

    pos =
      x: stage.x*-1 + stage.canvas.width/2 - size/2
      y: stage.y*-1 + 20

    # Interpolate the player pos on the map to the dot pos
    dotPos =
      x: (playerX / 9600) * size + pos.x
      y: (playerY / 9600) * size + pos.y


    @mapBorder = new createjs.Shape()
    @map = new createjs.Bitmap(@img)
    @dot = new createjs.Shape()

    @map.alpha = alpha
    @mapBorder.alpha = alpha
    @dot.alpha = alpha

    @map.scaleX = size / @img.width
    @map.scaleY = size / @img.height
    @map.x = pos.x
    @map.y = pos.y

    @mapBorder.graphics.beginStroke('black')
    @mapBorder.graphics.setStrokeStyle(15)
    @mapBorder.graphics.drawRect(pos.x, pos.y, size, size)

    @dot.graphics.beginFill("yellow")
    @dot.snapToPixel = true
    @dot.graphics.drawCircle(dotPos.x, dotPos.y, 15, 15)

    stage.addChild @mapBorder
    stage.addChild @map
    stage.addChild @dot

  close: =>
    @stage.removeChild @map
    @stage.removeChild @dot
    @stage.removeChild @mapBorder
