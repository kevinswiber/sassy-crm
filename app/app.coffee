ReportingRepository = require '../lib/reporting_repository'

class App
    @setup: (subscribe) ->
       subscribeToEvents(subscribe)

    subscribeToEvents = (subscribe) ->
        subscribe 'AccountCreated', (event) ->
            console.log "Account created: #{event.attributes.name}"
            repo = new ReportingRepository()
            repo.save
                aggregateId: event.attributes.id,
                name: event.attributes.name,
                modifiedAt: Date.now()
                status: event.attributes.status,
                type: 'report'
                reportType: 'AccountReport'

        subscribe 'AccountNameChanged',
            (event) -> console.log "Account name changed to: #{event.attributes.name}"

        subscribe 'AccountDeactivated',
            (event) -> console.log "Account deactivated: #{event.attributes.id}"

module.exports = App
