commandHandlers = require '../handlers/command_handlers'
eventHandlers = require '../handlers/event_handlers'

class Bus
    @subscribers = {}

    @send: (command) ->
        handler_name = 'get' + command.name + 'Handler'
        commandHandlers[handler_name](command) if commandHandlers[handler_name]

    @publish: (event) ->
        handler_name = 'get' + event.name + 'Handler'
        eventHandlers[handler_name] event if eventHandlers[handler_name]
        (handler event for handler in @subscribers[event.name]) if @subscribers[event.name]

    @subscribe: (eventName, handler) ->
        @subscribers[eventName] or= []
        @subscribers[eventName].push handler

module.exports = Bus
