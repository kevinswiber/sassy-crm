commandHandlers = require '../command_handlers'

class Bus
    @send: (command) ->
        handler_name = 'get' + command.name + 'Handler'
        commandHandlers[handler_name](command)

module.exports = Bus
