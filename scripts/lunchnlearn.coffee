# Description:
#   Control your sonos device from hubot
#
# Commands:
#  hubot lunchnlearn remember <topic> - Remember a n lunch and learn entry.
#  hubot lunchnlearn topics - Find out what lunch and learn topics are remembered.
#  hubot lunchnlearn list - Find out what lunch and learn topics are remembered.
#  hubot lunchnlearn forget <number> - Remove a lunch and learn entry.
#  hubot lunchnlearn clear - Forget all lunch and learn topics.
#
# Author:
#   cromwellryan

{EOL} = require('os')
ArrayMemory = require('../lib/array_memory')

list_topics = (memory, res) ->
  if(memory.any())
    res.emote "Let me think...#{EOL}#{memory}"
  else
    res.emote "Sorry, I'm drawing a blank."


module.exports = (robot) ->
  memory = new ArrayMemory(robot.brain, 'lunchnlearn')

  # Remember a lunch n learn topic
  robot.respond /lunch(?:and|n)learn remember (.*)/i, (res) ->
    idea = res.match[1]
    memory.remember(idea)
    res.emote "Got it! I'll remember _#{idea}_ until you tell me to `forget` it."

  # Provide a list of ideas for lunch n learn
  robot.respond /lunch(?:and|n)learn (topics|list)/i, (res) ->
    list_topics(memory,res)

  # Remove an item by number
  robot.respond /lunch(?:and|n)learn forget (\d+)/i, (res) ->
    numberToRemove = parseInt(res.match[1])

    if(numberToRemove == NaN)
      new res.emote "Sorry, not sure about that topic. Check help with `help lunchnlearn`."
    else
      memory.forget(numberToRemove)
      res.emote "No worries!  I'll take care of that for you right away"

  robot.respond /lunch(?:and|n)learn clear/i, (res) ->
    memory.clear()
    res.emote "Whoa! I'll do it, but that's pretty aggressive."
