dialogs = []
quests = []

class Marker
  constructor: (data) ->
    @pos = data.pos
    @id = data.id
    @done = false

class Quest
  constructor: (data) ->
    @name = data.name
    @state = 0
    @id = data.id
    @markers = []
    for marker in data.markers
      @markers.push new Marker(marker)
    @ordered = data.ordered or true
    @inProgress = false
    @isComplete

  completePart: (part) =>
    return unless @inProgress
    part = @getPart part
    return if @checkPartStatus part

    part.done = true
    @state = part.pos + 1

    if @checkComplete()
      console.log "You finished the quest!"
      @inProgress = false
      @isComplete = true

  checkComplete: =>
    @inProgress and not (_.find @markers, (m) -> not m.done)?

  start: =>
    @inProgress = true

  checkPartStatus: (part) =>
    return false unless @inProgress
    not @ordered or @getPart(part)?.pos is @state

  getPart: (id) =>
    _.find @markers, (m) => m.id is id

###### ADD SHIT TO COLLECTIONS ######
firstQuest =
  name: "First Quest"
  pos: 0
  id: 900
  ordered: true
  markers: [
    { pos: 0, id: 801, description: "Talk to Donkey"}
    { pos: 1, id: 802, description: "Get banana from Diddy"}
  ]

quests.push new Quest(firstQuest)


###### DIALOGS #######

######################
##### DIALOG 1 #######
######################
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
  text: "Lets go kill that evil professor. But first go talk to my brother Donkey"
  actions:[
    {
      type: "queststart"
      text: "Ok"
      value: {quest: 900}
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



######################
##### DIALOG 2 #######
######################
dialogs.push
  id: 127
  text: "I am drunk. Go talk to Diddy"
  actions:[
    {
      type: "questpart"
      text: "Ok"
      value: {quest: 900, part: 801}
    }
  ]

######################
##### DIALOG 3 #######
######################
dialogs.push
  id: 128
  text: "It's dangerous to go alone. Take this!"
  actions:[
    {
      type: "questpart"
      text: "Ok"
      value: {quest: 900, part: 802}
    }
  ]

######################
##### DIALOG 4 #######
######################
dialogs.push
  id: 129
  text: "Go kill some bunnies bro"
  actions:[
    {
      type: "done"
      text: "Word"
    }
  ]

######################
##### DIALOG 5 #######
######################
dialogs.push
  id: 130
  text: "BURP"
  actions:[
    {
      type: "done"
      text: "??"
    }
  ]

module.exports =
  findModel: (id) ->
    _.find dialogs.concat(quests), (d) -> d.id is id
