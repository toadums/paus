## Quest's onComplete can have type item, quest, ??.
##  If it is 'item', the player gets that item when the quest completes.
##  If it is 'quest', the player has access to start a new quest (#TODO. Might not make the game)

module.exports = [
  {
    name: "First Quest"
    pos: 0
    id: 900
    npc: 2
    ordered: true
    markers: [
      { pos: 0, id: 801, description: "Talk to Donkey", npc: 3}
      { pos: 1, id: 802, description: "Get banana from Diddy", npc: 2}
    ]
    onComplete: {
      type: "item"
      id: 300
    }
  }
]
