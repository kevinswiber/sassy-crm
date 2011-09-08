Account = require '../domain/account'
domainRepository = require '../lib/domain_repository'

class CommandHandlers
    getCreateAccountHandler: (command) ->
       account = new Account()
       account.create command.attributes
       domainRepository.save account

    getChangeAccountNameHandler: (command) ->
        account = domainRepository.find { entity: 'Account', id: command.attributes.id }
        account.changeName command.attributes.name
        domainRepository.save account

module.exports = new CommandHandlers()
