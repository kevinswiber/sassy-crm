Event = require './event'

class Entity
    applyEvent: (eventName, options) ->
        event = new Event eventName, options
        apply this, event

    apply = (obj, event) ->
        method_name = 'on' + event.name
        obj[method_name] event

module.exports = Entity
