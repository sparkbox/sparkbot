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

prefix = '(lunchandlearn|lunchnlearn|lnl|lunchlearn)'

list_topics = (memory, res) ->
  if(memory.any())
    res.emote "Let me think...#{EOL}#{memory}"
  else
    res.emote "Sorry, I'm drawing a blank."

match_command = (pattern) ->
  new RegExp("#{prefix} #{pattern}", 'i')


module.exports = (robot) ->
  memory = new ArrayMemory(robot.brain, 'lunchnlearn')


  # Remember a lunch n learn topic
  robot.respond (match_command("remember (.*)")), (res) ->
    idea = res.match[1]
    memory.remember(idea)
    res.emote "Got it! I'll remember _#{idea}_ until you tell me to `forget` it."

  # Provide a list of ideas for lunch n learn
  robot.respond match_command("(topics|list)"), (res) ->
    list_topics(memory,res)

  # Remove an item by number
  robot.respond match_command("forget (\d+)"), (res) ->
    numberToRemove = parseInt(res.match[1])

    if(numberToRemove == NaN)
      new res.emote "Sorry, not sure about that topic. Check help with `help lunchnlearn`."
    else
      memory.forget(numberToRemove)
      res.emote "No worries!  I'll take care of that for you right away"

  robot.respond match_command("clear"), (res) ->
    memory.clear()
    res.emote "Whoa! I'll do it, but that's pretty aggressive."
