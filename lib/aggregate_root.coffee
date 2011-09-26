Event = require './event'
uuid = require 'node-uuid'

class AggregateRoot
    id = undefined
    eventHandlers = {}

    setId: (i) -> id = i
    getId: () -> id

    @getNewId: () -> uuid()

    events: []

    apply: (eventName, attributes = {}) ->
        attributes.id = @getId() unless attributes.id
        event = new Event eventName, attributes
        applyEvent this, event

    clearEvents: () ->
        @events.length = 0

    on: (eventName, domainHandler) ->
        eventHandlers[eventName] = domainHandler

    applyEvent = (that, event) ->
        that.events.push event
        eventHandlers[event.name].call that, event if eventHandlers[event.name]

module.exports = AggregateRoot
