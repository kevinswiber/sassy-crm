cradle = require 'cradle'

dataStrategies =
    couch: ->
        couch = new(cradle.Connection)(
            "http://localhost",
            5984,
            { cache: true, raw: false }
        )

        couch.database 'sassy-crm'
    test: ->
        save: ->
        view: ->

strategy = 'couch'

module.exports.setStrategy = (strat) ->
    strategy = strat

module.exports.connect = () ->
   dataStrategies[strategy].call this
