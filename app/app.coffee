class App
    @setup: (subscribe) ->
       subscribeToEvents(subscribe)

    subscribeToEvents = (subscribe) ->
        subscribe 'AccountCreated',
            (event) -> console.log "Account created: #{event.attributes.name}"

        subscribe 'AccountNameChanged',
            (event) -> console.log "Account name changed to: #{event.attributes.name}"

        subscribe 'AccountDeactivated',
            (event) -> console.log "Account deactivated: #{event.attributes.id}"

module.exports = App
