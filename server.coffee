http = require 'http'
express = require 'express'

app = express()
app.use express.logger('dev')
app.use express.bodyParser()

app.use express.static(require('path').resolve(__dirname + "/public"))

server = http.createServer app
server.listen 3000

console.log "PAUS server now listening at http://localhost:3000"
