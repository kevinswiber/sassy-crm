JESSIE_PATH = './node_modules/jessie/bin'

desc 'Run specs'
task 'test', ->
    command = "NODE_ENV='test' #{JESSIE_PATH}/jessie spec -f nested"
    require('child_process').spawn '/bin/sh', ['-c', command], customFds: [0,0,0]
