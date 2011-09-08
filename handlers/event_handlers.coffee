require '../domain/account'

class EventHandlers
    getAccountCreatedHandler: (event) ->
        console.log "Account created: #{event.attributes.name}"

    getAccountNameChangedHandler: (event) ->
        console.log "Account name changed to: #{event.attributes.name}"

module.exports = new EventHandlers()
