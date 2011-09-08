Command = require './lib/command'
Bus = require './lib/bus'

createAccount = new Command 'CreateAccount', { id: 4, name: 'Super Company' }

Bus.send createAccount
