dataStrategy = require './data_strategy'

class ReportingRepository
    db = undefined
    
    constructor: () ->
        db = dataStrategy.connect()

    save: (report) ->
        ret = (err, res) ->
            console.log err if err?
            
        if report.id?
            db.save report.id, report
        else
            db.save report
            
    get: (id) ->
        report = undefined
        db.get id, (err, doc) ->
            console.log err if err?
            report = doc
        return report if report?

    find: (key, callback) ->
        db.view 'reports/byReportType', {key: key}, (err, docs) ->
            if err?
                console.log err
                return

            docs = docs.sort (a,b) ->
                return -1 if a.value.modifiedAt > b.value.modifiedAt
                return 1 if a.value.modifiedAt < b.value.modifiedAt
                return 0

            callback docs

    findByAggregate: (key, callback) ->
        db.view 'reports/byReportTypeAndAggregateId', {key: key}, (err, docs) ->
            if err?
                console.log err
                return

            docs = docs.sort (a,b) ->
                return -1 if a.value.modifiedAt > b.value.modifiedAt
                return 1 if a.value.modifiedAt < b.value.modifiedAt
                return 0

            callback docs

    update: (id, attributes, callback = ( -> )) ->
        db.merge id, attributes, (err, res) ->
            if err?
                console.log err
                return

            callback()
            
module.exports = new ReportingRepository()
