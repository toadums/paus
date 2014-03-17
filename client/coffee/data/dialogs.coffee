module.exports = [
  {
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
  }

  {
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
  }

  {
    id: 125
    text: "Lets go kill that evil professor. But first go talk to my brother Donkey"
    actions:[
      {
        type: "queststart"
        text: "Ok"
        value: {quest: 900}
      }
    ]
  }

  {
    id: 126
    text: "Grow some balls"
    actions: [
      {
        type: "done"
        text: "Atleast I am alive."
      }
    ]
  }


  ######################
  ##### DIALOG 2 #######
  ######################
  {
    id: 127
    text: "I am drunk. Go talk to Diddy"
    actions:[
      {
        type: "questpart"
        text: "Ok"
        value: {quest: 900, part: 801}
      }
    ]
  }

  ######################
  ##### DIALOG 3 #######
  ######################
  {
    id: 128
    text: "It's dangerous to go alone. Take this!"
    actions:[
      {
        type: "questpart"
        text: "Ok"
        value: {quest: 900, part: 802}
      }
    ]
  }

  ######################
  ##### DIALOG 4 #######
  ######################
  {
    id: 129
    text: "Go kill some bunnies bro"
    actions:[
      {
        type: "done"
        text: "Word"
      }
    ]
  }

  ######################
  ##### DIALOG 5 #######
  ######################
  {
    id: 130
    text: "DASD% $%@$%@$% $ %@#% #% DYSAD^% DS(^^SD *TSA *D^&& ST(S^&*D^SA&*D^(*&SD^ *())))"
    actions:[
      {
        type: "done"
        text: "???"
      }
    ]
  }


]
