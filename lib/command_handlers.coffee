Account = require '../domain/account'
domainRepository = require './domain_repository'

class CommandHandlers
    'CreateAccount': (attributes) ->
       account = Account.create attributes
       domainRepository.save account

    'ChangeAccountName': (attributes) ->
        account = domainRepository.find { entity: 'Account', id: attributes.id }
        account.changeName attributes.name
        domainRepository.save account

    'DeactivateAccount': (attributes) ->
        account = domainRepository.find { entity: 'Account', id: attributes.id }
        account.deactivate()
        domainRepository.save account

module.exports = new CommandHandlers()
