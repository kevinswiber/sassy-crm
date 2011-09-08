Account = require '../domain/account'

class DomainRepository
    save: (entity) ->
        require('./bus').publish event for event in entity.events
        entity.clearEvents()
    find: (obj) ->
        new Account()

module.exports = new DomainRepository()
