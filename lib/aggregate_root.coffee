Event = require './event'

class AggregateRoot
    events: []

    applyEvent: (eventName, options) ->
        event = new Event eventName, options
        apply this, event

    clearEvents: () ->
        @events.length = 0

    apply = (obj, event) ->
        obj.events.push event
        method_name = 'on' + event.name
        obj[method_name] event

module.exports = AggregateRoot
