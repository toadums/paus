dialogs = []

dialogs.push
  id: 123
  text: "Hello Traveller!"
  action:
    type: "goto"
    text: "Next"
    value: 124

dialogs.push
  id: 124
  text: "There are lots of bunnies. FUCK!"
  action:
    type: "goto"
    text: "Next"
    value: 125

dialogs.push
  id: 125
  text: "Lets go kill that evil professor"
  action:
    type: "done"
    text: "Done"

module.exports =
  findModel: (id) ->
    _.find dialogs, (d) -> d.id is id
