amqp = require 'amqp'

connection = amqp.createConnection()

connection.on 'ready', ->
    console.log 'ready'

    queue = connection.queue 'my-queue', (queue) ->
        queue.bind 'my-exchange', '#'

        queue.subscribe (message) ->
            console.log 'message received'
            console.log message
            console.log message.data.toString()
            
    exchange = connection.exchange 'my-exchange', {type: 'fanout'}, (exchange) ->
        exchange.publish 'stuff', 'Hello Rabbit!'
