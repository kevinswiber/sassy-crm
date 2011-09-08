Command = require './lib/command'
Bus = require './lib/bus'

createAccount = new Command 'CreateAccount', { id: 4, name: 'Super Company' }
changeName = new Command 'ChangeAccountName', {id: 4, name: 'Duper Company' }

Bus.send createAccount
Bus.send changeName
