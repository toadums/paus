module.exports = [

  # COUNTER FOR BUNNY KILL!!!! This could be in quest log


  # The hole
  {
    id: 170
    text: "A hole..."
    actions: [
      {
        type: "done"
        text: "I shouldn't"
      }
      {
        type: "warp"
        text: "YEAH I SHOULD"
      }
    ]
  }

  # Building Signs
  {
    id: 190
    text: "Student Union Building."
    actions: [
      {
        type: 'done'
        text: 'Cool'
      }
    ]
  }

  {
    id: 191
    text: "Clearihue - English and Klingon"
    actions: [
      {
        type: 'done'
        text: 'Cool'
      }
    ]
  }

  {
    id: 192
    text: "Cornett - So confusing it was turned into a literal maze. D:"
    actions: [
      {
        type: 'done'
        text: 'I bet there is something useful in here...'
      }
    ]
  }

  {
    id: 193
    text: "SSM - Math and Quantum Computing"
    actions: [
      {
        type: 'done'
        text: 'Cool'
      }
    ]
  }

  {
    id: 194
    text: "Elliot - Used to be physics, now its a prison"
    actions: [
      {
        type: 'done'
        text: 'Cool'
      }
    ]
  }

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
    text: "I wonder if there is anything useful in this old barrel"
    actions: [
      {
        type: 'goto'
        text: 'Investigate'
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
        text: "Those bunnies don't stand a chance."
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
        value: "The old man was your only hope..."
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
    text: "The deactivator is hidden behind some grass below this note. It will serve you well. But, if you really want to defeat the bunnies, you must deactivate them all at once. "
    actions: [
      {
        type: "goto"
        text: "Hmm...."
        value: 173
      }
    ]
  }

  {
    id: 173
    text: "To do so, you will need carrots as bait. Also, a trap and the signal amplifier. Go back to the old man after you get everything."
    actions: [
      {
        type: 'questpart'
        text: "Time to erabbicate these bastards."
        value: {quest: 911, part: 861}
      }
    ]
  }

  {
    id: 174
    text: "Carrots... There is a pretty good chance you will die if you eat them"
    actions: [
      {
        type: 'questpart'
        text: "I better pick some."
        value: {quest: 911, part: 862}
      }
      {
        type: 'gameover'
        text: "Eat Carrots #YOLO"
        value: "You are not invicible, Protaggy.."
      }

    ]
  }


]
