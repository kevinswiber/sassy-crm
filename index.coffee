Account = require './domain/account'
commands = require './commands'

createAccountCommand = commands.createAccount 4, 'Super Company'

console.log createAccountCommand
#account = new Account()
#account.create { name: 'Super Company' }
