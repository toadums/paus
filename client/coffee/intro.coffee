{wrap} = require 'coffee/utils'
module.exports = class Intro

  constructor: (@delegate) ->
    {
      @stage
    } = @delegate

    @pos = @stage.canvas.height
    @lines = []
    @story = "
It is the year 2064. Rabbits have been reintroduced to the UVic campus to satisfy the student body’s collective nostalgia for an imagined pastoral past. \n
 But the UVic administration has learned from their past mistakes, and stipulated one crucial difference this time around… \n
 Each rabbit has been equipped with augmented reality contact lenses and neural implants that allow the university to have complete control over their activities and keep an eye on all areas of the campus. \n
 This means the population can be kept in check, and messages can be relayed to and from campus visitors through the rabbits. \n However, not everyone thinks this is a good idea… \n \n

Mission brief: \n
 Environmental terrorist Dr. Antagonist has enclosed himself and UVic’s entire campus in an EMP forcefield. All electronics are rendered useless upon entry. \n
 Once he manages to hack into the world’s satellites, he plans on expanding the forcefield to encompass the entire world, destroying all technology in its wake. \n
 Your assignment is to infiltrate the campus and stop Dr. Antagonist before he can finish what he started. \n
 There’s just one small problem: The doctor has commandeered UVic’s Rabbit Control Room, allowing him to mobilize the normally peaceful rabbits into a furry army. \n
 Your mission starts now. Hop On! \n
 (press the esc key)
      "

    @visible = false

  show: =>
    @splitLines = wrap(@stage.canvas.getContext('2d'), @story, @stage.canvas.width / 2, "40px Arial")

    @container = new createjs.Container()
    i = 0
    j = 0

    for line in @splitLines
      @text = new createjs.Text line.trim(), "40px Arial", "white"
      @text.x = @stage.canvas.width / 4
      @text.y = i*40 + j*20

      @text.snapToPixel = true
      @text.textBaseline = "alphabetic"

      @container.addChild @text
      i++

      if line.indexOf('\n') > -1
        j++

    @container.x = 0
    @container.y = @stage.canvas.height

    @stage.addChild @container
    @visible = true

  close: =>
    @stage.removeChile(line) for line in @lines
    @visible = false

  tick: (event) =>

    @stage.removeChild @container

    @container.y = @pos

    @stage.addChild @container

    @pos-=2
    @stage.update()
