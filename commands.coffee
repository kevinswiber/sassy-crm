class Commands
    createAccount: (id, name) ->
        new CreateAccount id, name

class CreateAccount
    constructor: (@id, @name) ->
        
module.exports = new Commands()
