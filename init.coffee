cradle = require 'cradle'

console.log "Initializing..."

couch = new(cradle.Connection)(
    "http://localhost",
    5984,
    { cache: true, raw: false }
)

db = couch.database 'sassy-crm'

db.exists (err, exists) ->
    if exists
        console.log "Destroying database..."
        db.destroy( -> createDatabase())
    else
        createDatabase()

createDatabase = ->
    console.log "Creating database..."
    db.create( ->
        console.log "Creating views..."
        createViews()
        console.log "Done!")

createViews = ->
    db.save "_design/events",
        byAggregateId:
            map: (doc) ->
                if doc.type is 'Event'
                    emit doc.aggregateId, doc

    db.save "_design/reports",
        byReportTypeAndAggregateId:
            map: (doc) ->
                if doc.type is 'report'
                    emit {reportType: doc.reportType, aggregateId: doc.aggregateId}, doc
        byReportType:
            map: (doc) ->
                if doc.type is 'report'
                    emit {reportType: doc.reportType}, doc
