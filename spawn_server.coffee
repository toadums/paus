{spawn} = require "child_process"

module.exports.startServer = (port, path, callback) ->
  p = spawn("./start_server.sh", [port], {cwd: "."})
  p.stdout.on "data", (data) -> process.stdout.write data.toString()
  p.stderr.on "data", (data) -> process.stderr.write data.toString()
  p.on "exit", (code) -> console.log("Warning: exited with code", code) if code and code isnt 0
  callback()
  return { close: -> p.kill("SIGHUP") }