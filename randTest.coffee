#!/usr/bin/env coffee

_ = require 'underscore'
generators = require './generators.coffee'

ARGV = process.argv[2..]
ARGC = ARGV.length

TEST_FILE = ARGV[0]

if not TEST_FILE
    console.log "You must provide a test file: ./randTest.coffee examples/test1.js"
    return

timeAndReturn = (func, args) ->
    start = new Date().getMilliseconds()
    try
        result = func.apply @, args
    # If the function throws an error, return that as
    # the result. This will let us say that functions
    # are equivalent if they throw the same errors
    # for the same inputs.
    catch error
        result = error
    [result, (new Date().getMilliseconds() - start)]

incrementTime = (record, time) ->
    record[0] += time
    record[1] += 1

randTest = (f, g, argumentGenerators, options={}) ->

    trulyRandom = argumentGenerators == undefined

    areEqual = true
    iterations = options.iterations or 1000
    times =
        f: [0, 0]
        g: [0, 0]

    for i in [0...iterations]
        if trulyRandom then argumentGenerators = generators.getRandomArguments()
        args = _.map argumentGenerators, (gen) -> if _.isFunction(gen) then gen() else gen
        res1 = timeAndReturn f, args
        res2 = timeAndReturn g, args

        # Save timing stats
        incrementTime times.f, res1[1]
        incrementTime times.g, res2[1]

        areEqual = false unless res1[0] == res2[0]
        console.log i, res1[0], res2[0], args unless not options.verbose

        if not areEqual
            console.log "Not equivalent:"
            console.log "  f(#{args}) = #{res1[0]}"
            console.log "  g(#{args}) = #{res2[0]}"
            return

    console.log "\nf() and g() appear equivalent."
    console.log "Average times over #{iterations} runs:"
    console.log "  f():", times.f[0] / times.f[1]
    console.log "  g():", times.g[0] / times.g[1], "\n"


test = require "./#{TEST_FILE}"

randTest test.f, test.g, test.args, test
