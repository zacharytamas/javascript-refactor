_ = require 'underscore'

randInteger = (min=0, max=1000) -> _.random min, max
randIdentity = -> [undefined, false, true, null][_.random 3]
randString = (length) ->
    length = Math.floor(Math.random() * 100) unless length
    (_.map [1..length], -> String.fromCharCode _.random(65, 122)).join('')
randBool = -> [true, false][_.random 0, 1]

randomGenerators = [randInteger, randIdentity, randString, randBool]

getRandomArguments = ->
    count = _.random (randomGenerators.length * 2)
    args = []
    _(count).times -> args.push randomGenerators[_.random randomGenerators.length-1]
    return args

_.extend exports,
    randInteger: randInteger
    randIdentity: randIdentity
    randString: randString
    randBool: randBool
    getRandomArguments: getRandomArguments
