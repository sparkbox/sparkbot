# Description:
#   Use Skynet to determine if a thing that was said is actually something
#   S.H.E (Silicon Helix Entity) said.
#
# Dependencies:
#   "twss": "0.1.6"
#
# Configuration:
#   TWSS_ROOMS - Comma separated list of rooms in which to respond
#                inappropriately.
#
# Commands:
#   Just say something like, "that was hard", Hubot will do the rest.
#
# Author:
#   Jeremy Mack (mutewinter)

TWSS_THRESHOLD = 0.9

twss = require('twss')
twss.threshold = TWSS_THRESHOLD

module.exports = (robot) ->

  twssRooms = process.env.TWSS_ROOMS
  if twssRooms?
    twssRooms = twssRooms.split(',')

    robot.hear /(.*)/i, (msg) ->
      room = msg.envelope.room
      message = msg.match[1]

      console.log room, twssRooms

      if (room).toString() in twssRooms and twss.is(message)
        probability = twss.probability(message)

        if probability < 0.98
          msg.send "That's what she said."
        else
          msg.send msg.random [
            "Oh you're awful."
            "Come on, seriously?"
            "That's really inappropriate."
          ]
        console.log "Innuendo Probability for #{message} #{(probability * 100)/100}%"
  else
    console.error 'ERROR: You must define TWSS_ROOMS in your environment'
