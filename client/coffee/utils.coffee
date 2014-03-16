module.exports =
  wrap: (ctx,phrase,maxPxLength,textStyle) ->
    wa = phrase.split(" ")
    phraseArray = []
    lastPhrase = wa[0]
    l = maxPxLength
    measure = 0
    ctx.font = textStyle

    for i in [1..wa.length] by 1
      w = wa[i]
      measure = ctx.measureText(lastPhrase+w).width
      console.log measure
      if measure < l
        lastPhrase += (" "+w)
      else
        phraseArray.push lastPhrase
        lastPhrase = w

      if i is wa.length - 1
        phraseArray.push lastPhrase
        break

    phraseArray
