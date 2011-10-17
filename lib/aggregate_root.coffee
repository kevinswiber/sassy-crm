Event = require './event'
uuid = require 'node-uuid'

class AggregateRoot
    _id = undefined
    eventHandlers = {}

    id: (value) ->
        return _id if value == undefined
        _id = value

    @getNewId: () -> uuid()

    events: []

    apply: (eventName, attributes = {}) ->
        attributes.id = @id() unless attributes.id
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
