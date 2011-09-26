EventBus = require './lib/bus'
CommandBus = require './lib/command_bus'
App = require './app/app'

subscribeToEvents = (event, handler) -> EventBus.subscribe event, handler

App.setup(subscribeToEvents)

bus = new CommandBus()
bus.send ['CreateAccount', { name: 'Super Company' }]

bus.commit()
