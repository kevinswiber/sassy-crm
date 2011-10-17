AggregateRoot = require '../lib/aggregate_root'
Event = require '../lib/event'

describe 'AggregateRoot', ->
    it 'stores applied events', ->
        agg = new AggregateRoot()
        agg.apply 'TestEvent', { id: 12345 }

        expect(agg.events).toContain(new Event 'TestEvent', { id: 12345 })

    it 'clears events', ->
        agg = new AggregateRoot()
        agg.apply 'TestEvent', { id: 12345 }
        agg.clearEvents()

        expect(agg.events.length).toBe(0)

    it 'fires internal event handlers', ->
        agg = new AggregateRoot()

        event = null
        
        agg.on 'TestEvent', (evt) ->
            event = evt

        agg.apply 'TestEvent', { id: 12345 }

        waitsFor (-> event?), "Fire TestEvent.", 1000
        
        runs ->
            expect(event.attributes.id).toBe(12345)

    it 'generates a new id', ->
        expect(AggregateRoot.getNewId()).toBeTruthy()

    it 'stores an id', ->
        id = AggregateRoot.getNewId()
        agg = new AggregateRoot()
        agg.id id

        expect(agg.id()).toBe(id)
