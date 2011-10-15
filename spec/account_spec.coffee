Account = require '../domain/account'
Event = require '../lib/event'

describe 'Account', ->
    newAccount = -> Account.create { name: 'Tricky' }

    account = newAccount()

    beforeEach ->
        account = newAccount()

    it 'fires an AccountCreated event', ->
        expect(account.events).toContain(new Event 'AccountCreated', { name: 'Tricky', id: account.getId() })

    it 'fires an AccountNameChanged event', ->
        account.changeName 'Acme'
        expect(account.events).toContain(new Event 'AccountNameChanged', { name: 'Acme', id: account.getId() })

    it 'fires an AccountDeactivated event', ->
        account.deactivate()
        expect(account.events).toContain(new Event 'AccountDeactivated', { id: account.getId() })
