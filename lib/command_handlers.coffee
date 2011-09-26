Account = require '../domain/account'
domainRepository = require './domain_repository'

class CommandHandlers
    'CreateAccount': (attributes, callback) ->
       account = Account.create attributes
       domainRepository.save 'Account', account, callback

    'ChangeAccountName': (attributes, callback) ->
        account = domainRepository.find new Account(), attributes.id,
            (acc) ->
                acc.changeName attributes.name
                domainRepository.save 'Account', acc, callback

    'DeactivateAccount': (attributes) ->
        account = domainRepository.find new Account(), attributes.id,
            (acc) ->
                acc.deactivate()
                domainRepository.save 'Account', acc, callback

module.exports = new CommandHandlers()
