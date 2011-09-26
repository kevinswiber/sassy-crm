CommandBus = require '../lib/command_bus'
reportingRepository = require '../lib/reporting_repository'

class App
    constructor: (subscribe) ->
       subscribeToEvents(subscribe)

    subscribeToEvents = (subscribe) ->
        subscribe 'AccountCreated', (event) ->
            console.log "Account created: #{event.attributes.name}"
            reportingRepository.save
                aggregateId: event.attributes.id,
                name: event.attributes.name,
                modifiedAt: Date.now()
                status: event.attributes.status,
                type: 'report'
                reportType: 'AccountReport'

        subscribe 'AccountNameChanged', (event) ->
            console.log "Account name changed to: #{event.attributes.name}"
            reportingRepository.findByAggregate {reportType: 'AccountReport', aggregateId: event.attributes.id},
                (docs) ->
                    reportingRepository.update(doc.id, {name: event.attributes.name}) for doc in docs

        subscribe 'AccountDeactivated',
            (event) -> console.log "Account deactivated: #{event.attributes.id}"

    run: ->
        bus = new CommandBus()
        bus.send ['CreateAccount', { name: 'Super Company' }]
        bus.commit( ->
            reportingRepository.find {reportType: 'AccountReport'}, (docs) ->
                reports = []
                reports.push doc.value for doc in docs

                if reports.length
                    bus.send ['ChangeAccountName', {id: reports[0].aggregateId, name: 'Horsewarsh'}]
                    bus.commit()
        )

module.exports = App
