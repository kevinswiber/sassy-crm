Entity = require '../lib/entity'

class Account extends Entity
    id = 0
    name = {}

    create: (attrs) ->
        account = new Account()
        account.applyEvent 'AccountCreated', attrs

    onAccountCreated: (event) ->
        id = event.attributes.id
        name = event.attributes.name
        console.log "Account created: #{name}"

module.exports = Account
