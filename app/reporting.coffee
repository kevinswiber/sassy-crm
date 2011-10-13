EventBus = require '../lib/event_bus'
reportingRepository = require '../lib/reporting_repository'

module.exports.setup = ->
    EventBus.subscribe 'AccountCreated', (event) ->
        console.log "Account created: #{event.attributes.name}"
        reportingRepository.save
            aggregateId: event.attributes.id,
            name: event.attributes.name,
            modifiedAt: Date.now()
            status: event.attributes.status,
            type: 'report'
            reportType: 'AccountReport'

    EventBus.subscribe 'AccountNameChanged', (event) ->
        console.log "Account name changed to: #{event.attributes.name}"
        reportingRepository.findByAggregate {reportType: 'AccountReport', aggregateId: event.attributes.id},
            (docs) ->
                reportingRepository.update(doc.id, {name: event.attributes.name}) for doc in docs

    EventBus.subscribe 'AccountDeactivated',
        (event) -> console.log "Account deactivated: #{event.attributes.id}"

