dialogs = []

dialogs.push
  id: 123
  text: "Hello Traveller!"
  actions:[
    {
      type: "goto"
      text: "Oh Hai"
      value: 124
    }
    {
      type: "done"
      text: "LEAVE ME ALONE"
    }
  ]
dialogs.push
  id: 124
  text: "There are lots of bunnies. Let's fight them"
  actions:[
    {
      type: "goto"
      text: "I am thirsty...for blood"
      value: 125
    }
    {
      type: "goto"
      text: "I am a coward."
      value: 126
    }
  ]

dialogs.push
  id: 125
  text: "Lets go kill that evil professor"
  actions:[
    {
      type: "done"
      text: "Done"
    }
  ]

dialogs.push
  id: 126
  text: "Grow some balls"
  actions: [
    {
      type: "done"
      text: "Atleast I am alive."
    }
  ]
module.exports =
  findModel: (id) ->
    _.find dialogs, (d) -> d.id is id
