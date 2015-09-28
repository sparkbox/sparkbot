{EOL} = require('os')

class SonosHelp
  constructor: ->
    @entries = {
      "sparkbot play": 'Plays music in the big room, using the currently selected playlist in sonos.'
      "sparkbot pause": 'Pauses music'
      "sparkbot play": 'Plays music again'
      "sparkbot next": 'Plays next track'
      "sparkbot what's playing": 'Returns data about the song playing in the big room.'
    }

  showAll: (res) ->
    message = ("`#{command}` #{description}" for command, description of @entries)
    res.emote message.join(EOL)

module.exports = (robot) ->
  robot.respond /help sonos/i, (res) ->
    new SonosHelp().showAll(res)

