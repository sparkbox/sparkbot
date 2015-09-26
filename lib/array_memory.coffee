{EOL} = require('os')
_ = require('lodash')

class ArrayMemory
  constructor: (@brain, @key) ->

  remember: (idea) ->
    memory = @ideas()

    memory.push idea

    @brain.set @key, memory

  forget: (number) ->
    memory = @ideas()

    _.pullAt(memory, number-1)

    @brain.set @key, memory

  clear: ->
    @brain.set @key, []

  ideas: ->
    @brain.get('lunchnlearn') || []

  any: ->
    _.any(@ideas())

  toString: (joinWith = EOL)->
    @ideas()
      .map( (idea, index) -> "#{index+1}: #{idea}" )
      .join(joinWith)

module.exports = ArrayMemory
