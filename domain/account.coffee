AggregateRoot = require '../lib/aggregate_root'

class Account extends AggregateRoot
    name = ''
    state = ''

    constructor: () ->
        @on 'AccountCreated', (event) ->
            @setId event.attributes.id
            name = event.attributes.name
            state = 'New'

        @on 'AccountNameChanged', (event) ->
            name = event.attributes.name

        @on 'AccountDeactivated', (event) ->
            state = 'Deactivated'

    @create: (attributes = {}) ->
        attributes.id = @getNewId()

        account = new Account()
        account.apply 'AccountCreated', attributes
        account

    changeName: (n) ->
        @apply 'AccountNameChanged', { name: n }

    deactivate: () ->
        @apply 'AccountDeactivated'

module.exports = Account
