module.exports = [

  # COUNTER FOR BUNNY KILL!!!! This could be in quest log

  # Initial quest, get sword
  {
    id: 150
    text: "What? Another Human??? If you want to survive the rabbit invasion go to SSM."
    actions: [
      {
        type: 'queststart'
        text: 'What the hell..'
        value: {quest: 901}
      }
    ]
  }

  {
    id: 151
    text: "No new messages D:"
    actions: [
      {
        type: 'done'
        text: '...'
      }
    ]
  }

  {
    id: 152
    text: "You find a hole in the tree."
    actions: [
      {
        type: 'goto'
        text: 'investigate'
        value: 153
      }
      {
        type: 'done'
        text: 'Leave it'
      }
    ]
  }

  {
    id: 153
    text: "You find a sword!"
    actions: [
      {
        type: "questpart"
        text: "Now I just need to figure out how to turn it on..."
        value: {quest: 901, part: 850}
      }
    ]
  }







  ## Dialogs for when you meet the old guy, and do the first part of main quest
  {
    id: 161
    text: "Pssst ..."
    actions: [
      {
        type: "goto"
        text: "What the..."
        value: 162
      }
      {
        type: "done"
        text: "Leave."
      }
      {
        type: "gameover"
        text: "Kill the old man"
        value: { text: "The old man was your only hope..." }
      }
    ]
  }

  {
    id: 162
    text: "Thank god you're here. My hip is out, I need your help!"
    actions: [
      {
        type: "goto"
        text: "What can I do?"
        value: 163
      }
    ]
  }

  {
    id: 163
    text: "Oh, I see you found Turpin, the bunny killer. Instead you should look for the bunny remote."
    actions: [
      {
        type: "goto"
        text: "What is the bunny remote?"
        value: 164
      }
      {
        type: "done"
        text: "Nah, i <3 bloodshed"
      }
    ]
  }

  {
    id: 164
    text: "It’s a device to disconnect the bunnies from Dr. Antagonist’s control."
    actions: [
      {
        type: "goto"
        text: "Where do I look"
        value: 165
      }
    ]
  }

  {
    id: 165
    text: "I’ve hidden pieces around campus so Dr. Antaggy doesn’t find it. First, get the deactivator. It’s near building 451."
    actions: [
      {
        type: "queststart"
        text: "Word."
        value: {quest: 911}
      }
    ]
  }



  # THE LIBRARRRRRY of alexandria
  {
    id: 171
    text: "Library Closed. Analog books no longer exist."
    actions: [
      {
        type: "done"
        text: "Hmm...What an interesting critique of the future."
      }
    ]
  }

  {
    id: 172
    text: "Congratulations! U found the deactivator. This will serve u well. But, if u rly want 2 defeat da bunnies, u must deactivate them all @ once.
          2 do so, u will need carrots as bait. Also, a trap and the signal amplifier."
    actions: [
      {
        type: 'questpart'
        text: "Cool!"
        value: {quest: 911, part: 861}
      }
    ]
  }

























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
