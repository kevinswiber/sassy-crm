AggregateRoot = require '../lib/aggregate_root'

class Account extends AggregateRoot
    id = 0
    name = {}

    create: (attrs) ->
        account = new Account()
        account.applyEvent 'AccountCreated', attrs

    changeName: (n) ->
        @applyEvent 'AccountNameChanged', { name: n }

    onAccountCreated: (event) ->
        id = event.attributes.id
        name = event.attributes.name

    onAccountNameChanged: (event) ->
        name = event.attributes.name

module.exports = Account
