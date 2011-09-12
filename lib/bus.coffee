commandHandlers = require './command_handlers'

class Bus
    @subscribers = {}

    @send: (command) ->
        commandName = command[0]
        attributes = command[1]
        handler_name = commandName

        commandHandlers[handler_name](attributes) if commandHandlers[handler_name]

    @publish: (event) ->
        (handler event for handler in @subscribers[event.name]) if @subscribers[event.name]

    @subscribe: (eventName, handler) ->
        @subscribers[eventName] or= []
        @subscribers[eventName].push handler

module.exports = Bus
