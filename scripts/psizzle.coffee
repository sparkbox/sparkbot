# Description:
#   Returns some sizzle when sizzle is spoken.
#
# Commands:
#   sizzle - Get some sizzle
#
# Author:
#   Jeremy Mack
module.exports = (robot) ->

  robot.hear /sizzle/i, (msg) ->
    msg.send "http://www.psizzle.biz/psizzlebiz-Bling.jpg"
