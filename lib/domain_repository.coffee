dataStrategy = require './data_strategy'

class DomainRepository
    db = undefined

    constructor: () ->
        db = dataStrategy.connect()

    save: (type, entity, callback = ( -> )) ->
        aggregateId = entity.id()
        events = entity.events

        save = (index, saveCompleted) ->
            event = events[index]
            event.aggregateId = aggregateId
            event.publishedAt = Date.now()
            event.type = 'Event'
            event.aggregateType = type

            db.save event, (err, res) ->
                if err?
                    console.log err
                    return

                require('./event_bus').publish event
                nextIndex = index + 1

                if nextIndex < events.length - 1
                    save(nextIndex, complete)
                else
                    saveCompleted()
                    return
        save 0, ->
            entity.clearEvents()
            callback()

    find: (aggregate, id, callback) ->
        db.view 'events/byAggregateId', {key: id}, (err, docs) ->
            if err?
                console.log err
                return
            
            docs = docs.sort (a,b) ->
                return -1 if a.value.publishedAt < b.value.publishedAt
                return 1 if a.value.publishedAt > b.value.publishedAt
                return 0

            aggregate.apply doc.value.name, doc.value.attributes for doc in docs
            aggregate.clearEvents()
            callback aggregate

module.exports = new DomainRepository()
