AggregateRoot = require '../lib/aggregate_root'
Event = require '../lib/event'

describe 'aggregate root', ->
    it 'should store applied events', ->
        agg = new AggregateRoot()
        agg.apply 'TestEvent', { id: 12345 }

        expect(agg.events).toContain(new Event 'TestEvent', { id: 12345 })

    it 'should clear events', ->
        agg = new AggregateRoot()
        agg.apply 'TestEvent', { id: 12345 }
        agg.clearEvents()

        expect(agg.events.length).toBe(0)

    it 'should fire internal event handlers', ->
        agg = new AggregateRoot()

        agg.on 'TestEvent', (event) ->
            expect(event.attributes.id).toBe(12345)

        agg.apply 'TestEvent', { id: 12345 }

    it 'should generate a new id', ->
        expect(AggregateRoot.getNewId()).toBeTruthy()

    it 'should store an id', ->
        id = AggregateRoot.getNewId()
        agg = new AggregateRoot()
        agg.setId id

        expect(agg.getId()).toBe(id)
