Bus = require './lib/bus'
App = require './app/app'

subscribeToEvents = (event, handler) -> Bus.subscribe event, handler

App.setup(subscribeToEvents)

Bus.send ['CreateAccount', { name: 'Super Company' }]
Bus.send ['ChangeAccountName', { id: 4, name: 'Totally Awesome Incorporated' }]
Bus.send ['DeactivateAccount', { id: 4 }]
