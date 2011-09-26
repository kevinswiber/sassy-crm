cradle = require 'cradle'

class ReportingRepository
    db = undefined
    constructor: () ->
        couch = new(cradle.Connection)(
            "http://localhost",
            5984,
            { cache: true, raw: false }
        )

        db = couch.database 'sassy-crm'

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

module.exports = ReportingRepository
