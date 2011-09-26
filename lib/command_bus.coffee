commandHandlers = require './command_handlers'

class CommandBus
    commands = []

    length: -> commands.length

    send: (command) ->
            commands.push command

    commit: (callback = (->)) ->
        commit = (index, commitCompleted) ->
            command = commands[index]
            commandName = command[0]
            attributes = command[1]

            commandHandlers[commandName] attributes, ->
                nextIndex = index + 1

                if nextIndex < commands.length
                    commit nextIndex
                else
                    commitCompleted()
                    return

        if commands.length
            commit 0, () ->
                commands.length = 0
                callback()

module.exports = CommandBus
