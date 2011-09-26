EventBus = require './lib/bus'
App = require './app/app'

subscribeToEvents = (event, handler) -> EventBus.subscribe event, handler

app = new App(subscribeToEvents)
app.run()
