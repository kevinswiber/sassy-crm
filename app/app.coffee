CommandBus = require '../lib/command_bus'
reportingRepository = require '../lib/reporting_repository'
reporting = require './reporting'

module.exports.run = ->
    reporting.setup()

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
