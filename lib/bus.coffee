class Bus
    @subscribers = {}

    @publish: (event) ->
        (handler event for handler in @subscribers[event.name]) if @subscribers[event.name]

    @subscribe: (eventName, handler) ->
        @subscribers[eventName] or= []
        @subscribers[eventName].push handler

module.exports = Bus
