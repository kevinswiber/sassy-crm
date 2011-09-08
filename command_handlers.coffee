Account = require './domain/account'

class CommandHandlers
    getCreateAccountHandler: (command) ->
       account = new Account()
       account.create command.attributes

module.exports = new CommandHandlers()
